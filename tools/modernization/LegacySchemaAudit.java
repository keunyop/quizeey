import java.io.*;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.sql.*;
import java.util.*;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.SafeConstructor;

/** Read-only metadata audit. Never starts Spring or its generators; never prints credentials. */
public final class LegacySchemaAudit {
    private static final List<String> TABLES = Arrays.asList("test", "version", "question", "example", "explanation", "question_stats");
    @SuppressWarnings("unchecked")
    private static Map<String,Object> map(Object value) { return (Map<String,Object>)value; }
    private static String json(Object value) {
        if (value == null) return "null";
        if (value instanceof Boolean || value instanceof Number) return value.toString();
        if (value instanceof Map) {
            List<String> items = new ArrayList<>();
            for (Map.Entry<?,?> e : ((Map<?,?>)value).entrySet()) items.add(json(e.getKey().toString())+":"+json(e.getValue()));
            return "{"+String.join(",",items)+"}";
        }
        if (value instanceof List) {
            List<String> items = new ArrayList<>();
            for (Object e : (List<?>)value) items.add(json(e));
            return "["+String.join(",",items)+"]";
        }
        StringBuilder s = new StringBuilder("\"");
        for (char c : value.toString().toCharArray()) {
            if (c == '"' || c == '\\') s.append('\\').append(c);
            else if (c < 32) s.append(String.format("\\u%04x",(int)c));
            else s.append(c);
        }
        return s.append('"').toString();
    }
    private static List<Map<String,Object>> rows(Connection c, String sql, String database) throws SQLException {
        try (PreparedStatement statement=c.prepareStatement(sql)) {
            statement.setQueryTimeout(5);
            if (database!=null) statement.setString(1,database);
            try (ResultSet r=statement.executeQuery()) {
                List<Map<String,Object>> output=new ArrayList<>();
                ResultSetMetaData meta=r.getMetaData();
                while(r.next()) {
                    if(output.size()>=2000) throw new SQLException("Metadata bound exceeded","54000");
                    Map<String,Object> row=new LinkedHashMap<>();
                    for(int n=1;n<=meta.getColumnCount();n++) row.put(meta.getColumnLabel(n),r.getString(n));
                    output.add(row);
                }
                return output;
            }
        }
    }
    public static void main(String[] args) throws Exception {
        Map<String,Object> report=new LinkedHashMap<>();
        report.put("scope","Read-only legacy schema metadata; no source row data exported");
        report.put("readOnly",true);
        report.put("phase","configuration");
        try {
            Yaml yaml=new Yaml(new SafeConstructor());
            List<Map<String,Object>> documents=new ArrayList<>();
            try(InputStream file=Files.newInputStream(Paths.get(args[0]))) {
                for(Object document:yaml.loadAll(file)) if(document instanceof Map) documents.add(map(document));
            }
            String active=null;
            for(Map<String,Object> document:documents) {
                if(!(document.get("spring") instanceof Map)) continue;
                Object profiles=map(document.get("spring")).get("profiles");
                if(profiles instanceof Map && map(profiles).get("active")!=null) active=String.valueOf(map(profiles).get("active"));
            }
            Map<String,Object> ds=new LinkedHashMap<>();
            for(Map<String,Object> document:documents) {
                if(!(document.get("spring") instanceof Map)) continue;
                Map<String,Object> spring=map(document.get("spring"));
                Object profile=spring.get("profiles");
                if((profile==null || profile instanceof Map || Objects.equals(String.valueOf(profile),active)) && spring.get("datasource") instanceof Map) ds.putAll(map(spring.get("datasource")));
            }
            if(ds.isEmpty()) throw new IllegalArgumentException();
            if(args.length==4 && args[3].equals("stdin-credentials")) {
                String input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8)).readLine();
                if(input==null || input.length()>4096) throw new IllegalArgumentException();
                Object value=yaml.load(input);
                if(!(value instanceof Map) || !map(value).keySet().equals(new HashSet<>(Arrays.asList("username","password")))) throw new IllegalArgumentException();
                Map<String,Object> supplied=map(value);
                for(String key:Arrays.asList("username","password")) if(!(supplied.get(key) instanceof String) || ((String)supplied.get(key)).isEmpty()) throw new IllegalArgumentException();
                ds.putAll(supplied);
                report.put("credentialSource","stdin-memory-only");
            } else report.put("credentialSource","existing-source-configuration");
            String original=String.valueOf(ds.get("url"));
            if(!original.startsWith("jdbc:mariadb://")) throw new IllegalArgumentException();
            URI uri=new URI(original.substring(5));
            // Use exactly the source-configured host/database; discard all original URL options.
            report.put("phase","target_validation");
            if(uri.getHost()==null || uri.getUserInfo()!=null ||
               uri.getPath()==null || !uri.getPath().matches("/[A-Za-z0-9_-]+")) throw new IllegalArgumentException();
            String database=uri.getPath().substring(1);
            report.put("targetEvidence","owner-confirmed-source-address; AWS instance identity unverified");
            report.put("rdsHostname",uri.getHost().endsWith(".rds.amazonaws.com"));
            report.put("tlsMode","verify-full");
            String url="jdbc:mariadb://"+uri.getHost()+":"+(uri.getPort()<0?3306:uri.getPort())+"/"+database;
            Properties properties=new Properties();
            properties.setProperty("user",String.valueOf(ds.get("username")));
            properties.setProperty("password",String.valueOf(ds.get("password")));
            properties.setProperty("sslMode","verify-full");
            if(uri.getHost().endsWith(".rds.amazonaws.com")) properties.setProperty("serverSslCert",Paths.get(args[1]).toAbsolutePath().toString());
            properties.setProperty("connectTimeout","5000");
            properties.setProperty("socketTimeout","5000");
            Class.forName("org.mariadb.jdbc.Driver");
            DriverManager.setLoginTimeout(5);
            report.put("phase","connection");
            try(Connection connection=DriverManager.getConnection(url,properties)) {
                connection.setReadOnly(true);
                try(Statement control=connection.createStatement()) {
                    control.setQueryTimeout(5);
                    control.execute("START TRANSACTION READ ONLY");
                }
                try {
                    report.put("phase","metadata");
                    report.put("server",rows(connection,"SELECT VERSION() AS version, @@character_set_database AS charset, @@collation_database AS collation, @@time_zone AS session_timezone, @@system_time_zone AS system_timezone",null));
                    report.put("tables",rows(connection,"SELECT TABLE_NAME,ENGINE,TABLE_COLLATION,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE TABLE_SCHEMA=? AND TABLE_NAME IN ('test','version','question','example','explanation','question_stats') ORDER BY TABLE_NAME",database));
                    report.put("columns",rows(connection,"SELECT TABLE_NAME,COLUMN_NAME,ORDINAL_POSITION,COLUMN_TYPE,IS_NULLABLE,COLUMN_DEFAULT,EXTRA,CHARACTER_SET_NAME,COLLATION_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=? AND TABLE_NAME IN ('test','version','question','example','explanation','question_stats') ORDER BY TABLE_NAME,ORDINAL_POSITION",database));
                    report.put("indexes",rows(connection,"SELECT TABLE_NAME,INDEX_NAME,NON_UNIQUE,SEQ_IN_INDEX,COLUMN_NAME FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=? AND TABLE_NAME IN ('test','version','question','example','explanation','question_stats') ORDER BY TABLE_NAME,INDEX_NAME,SEQ_IN_INDEX",database));
                    Map<String,Object> ddl=new LinkedHashMap<>();
                    for(String table:TABLES) {
                        try(Statement statement=connection.createStatement()) {
                            statement.setQueryTimeout(5);
                            try(ResultSet r=statement.executeQuery("SHOW CREATE TABLE `"+table+"`")) {
                                if(r.next()) ddl.put(table,r.getString(2));
                            }
                        }
                    }
                    report.put("ddl",ddl);
                    report.put("status","verified");
                } finally {
                    try(Statement control=connection.createStatement()) { control.execute("ROLLBACK"); }
                }
            }
        } catch(SQLException e) {
            report.put("status","unavailable"); report.put("sqlState",e.getSQLState()); report.put("vendorCode",e.getErrorCode());
            // SQL exception messages can disclose the host/user/database. Never serialize or print them.
        } catch(Exception e) { report.put("status","configuration_or_tls_unavailable"); report.put("errorClass",e.getClass().getSimpleName()); }
        Files.write(Paths.get(args[2]),(json(report)+"\n").getBytes(StandardCharsets.UTF_8));
        System.out.println("Legacy schema metadata audit: "+report.get("status")+". Private result saved; no credentials printed.");
    }
}
