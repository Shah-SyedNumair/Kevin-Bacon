package ca.yorku.eecs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.stream.Collectors;
import org.neo4j.driver.v1.AuthTokens;
import org.neo4j.driver.v1.Config;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import com.sun.net.httpserver.HttpExchange;

class Utils {
        
        public static String uriDb = "bolt://localhost:7687";
    public static String uriUser ="http://localhost:8080";
    public static Config config = Config.builder().withoutEncryption().build();
    public static Driver driver = GraphDatabase.driver(uriDb, AuthTokens.basic("neo4j","123456"), config);
        
        public static String convert(InputStream inputStream) throws IOException {
                
        try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
            return br.lines().collect(Collectors.joining(System.lineSeparator()));
        }
    }

    public static String getBody(HttpExchange he) throws IOException {
                // https://stackoverflow.com/a/10910032
                InputStreamReader isr = new InputStreamReader(he.getRequestBody(), "utf-8");
            BufferedReader br = new BufferedReader(isr);
            
            int b;
            StringBuilder buf = new StringBuilder();
            while ((b = br.read()) != -1) {
                buf.append((char) b);
            }

            br.close();
            isr.close();
	    
        return buf.toString();
        }
}