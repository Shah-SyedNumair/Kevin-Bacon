package ca.yorku.eecs;

import static org.neo4j.driver.v1.Values.parameters;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.neo4j.driver.v1.*;
import org.neo4j.driver.v1.Record;
import org.neo4j.driver.v1.exceptions.NoSuchRecordException;

import java.io.*;
import java.net.URI;
import java.net.URLDecoder;
import java.util.*;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;

public class Adder  implements HttpHandler{

	@Override
	public void handle(HttpExchange r) throws IOException {
		// TODO Auto-generated method stub
		try {
			if (r.getRequestMethod().equals("GET")) {
				handleGet(r);
				System.out.println("get");
			} else if (r.getRequestMethod().equals("PUT")) {
				handlePut(r);
				System.out.println("put");
			} else {
				sendString(r, "Not properly Formated\n", 400);
			}
		} catch (Exception e) {
        	sendString(r, "Server error\n", 500);
		}
		
	}

	private void handlePut(HttpExchange r) throws IOException {
		// TODO Auto-generated method stub
		try {
			JSONObject deserial = new JSONObject(Utils.getBody(r));
			String path = r.getRequestURI().getPath();
			
			if(path.contains("addActor") && deserial.has("actorId") && deserial.has("name")) {
				addActor(r, deserial.getString("name"), deserial.getString("actorId"));
			} else if(path.contains("addMovie") && deserial.has("movieId") && deserial.has("name")) {
				addMovie(r, deserial.getString("name"), deserial.getString("movieId"));
			} else if(path.contains("addStudio") && deserial.has("studioId") && deserial.has("name")) {
				addStudio(r, deserial.getString("name"), deserial.getString("studioId"));
			} else if(path.contains("addRating") && deserial.has("ratingId") && deserial.has("name")) {
				addRating(r, deserial.getString("name"), deserial.getString("ratingId"));
			} else if(path.contains("addLanguage") && deserial.has("languageId") && deserial.has("name")) {
				addLanguage(r, deserial.getString("name"), deserial.getString("languageId"));
			}else if(path.contains("addRelationship") && deserial.has("actorId") && deserial.has("movieId")) {
				addRelationship(r, deserial.getString("actorId"), deserial.getString("movieId"));
			} else if(path.contains("addStudioRelation") && deserial.has("studioId") && deserial.has("movieId")) {
				addStudioRelation(r, deserial.getString("studioId"), deserial.getString("movieId"));
			}else if(path.contains("addRatingRelation") && deserial.has("ratingId") && deserial.has("movieId")) {
				addRatingRelation(r, deserial.getString("ratingId"), deserial.getString("movieId"));
			}else if(path.contains("addLanguageRelation") && deserial.has("languageId") && deserial.has("movieId")) {
				addLanguageRelation(r, deserial.getString("languageId"), deserial.getString("movieId"));
			}else {
				sendString(r, "Missing information or not properly formated\n", 400);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
        	sendString(r, "Server error\n", 500);

		}

	}

	private void handleGet(HttpExchange r) throws IOException {
		// TODO Auto-generated method stub
		try {
			JSONObject deserial = new JSONObject(Utils.getBody(r));
			String path = r.getRequestURI().getPath();

			if (path.contains("getActor") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("actorId"))) {
				getActor(r, deserial.getString("actorId"));
			} else if (path.contains("getMovie") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("movieId"))) {
				getMovie(r, deserial.getString("movieId"));
			} else if (path.contains("getStudio") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("studioId"))) {
				getStudio(r, deserial.getString("studioId"));
			}else if (path.contains("getRating") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("ratingId"))) {
				getRating(r, deserial.getString("ratingId"));
			}else if (path.contains("getLanguage") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("languageId"))) {
				getLanguage(r, deserial.getString("languageId"));
			}else if(path.contains("hasRelationship") && deserial.has("actorId") && deserial.has("movieId")){
				hasRelationship(r, deserial.getString("actorId"), deserial.getString("movieId"));
			}else if(path.contains("hasRelationship") && deserial.has("actorId") && deserial.has("movieId")){
				hasStudioRelationship(r, deserial.getString("actorId"), deserial.getString("movieId"));
			}else if(path.contains("hasRelationship") && deserial.has("actorId") && deserial.has("movieId")){
				isRated(r, deserial.getString("actorId"), deserial.getString("movieId"));
			}else if(path.contains("hasRelationship") && deserial.has("actorId") && deserial.has("movieId")){
				speaksIn(r, deserial.getString("actorId"), deserial.getString("movieId"));
			}else if  (path.contains("computeBaconNumber") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("actorId"))) {
				
			}else if  (path.contains("computeBaconPath") && (deserial.length() == 1 || deserial.length() == 2)
					&& (deserial.has("actorId"))) {
				computeBaconPath(r, deserial.getString("actorId"));
			}else {
				sendString(r, "Missing info\n", 400);
			}
		}catch(Exception e) {
        	sendString(r, "Server error\n", 500);

		}
	}
	
	//Methods for all the PUT requests
	private void addActor(HttpExchange r, String name, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: actor {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) != null){
				session.writeTransaction(tx -> tx.run("MERGE (a:actor {name: $x, id: $y})", 
						parameters("x", name, "y", id)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "id alread exists\n", 400);
			}
		}
	}
	
	private void addMovie(HttpExchange r, String name, String id) throws IOException {
		
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) != null){
				session.writeTransaction(tx -> tx.run("MERGE (a:movie {name: $x, id: $y})", 
						parameters("x", name, "y", id)));
				session.close();
				sendString(r, "add Successful\n", 200);
			}else {
				sendString(r, "id alread exists\n", 400);
			}
		}
		
	}
	
	private void addStudio(HttpExchange r, String name, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: studio {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) != null){
				session.writeTransaction(tx -> tx.run("MERGE (a:studio {name: $x, id: $y})", 
						parameters("x", name, "y", id)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "id alread exists\n", 400);
			}
		}
	}
	
	private void addRating(HttpExchange r, String name, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: rating {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) != null){
				session.writeTransaction(tx -> tx.run("MERGE (a:rating {name: $x, id: $y})", 
						parameters("x", name, "y", id)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "id alread exists\n", 400);
			}
		}
	}
	
	private void addLanguage(HttpExchange r, String name, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: language {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) != null){
				session.writeTransaction(tx -> tx.run("MERGE (a:language {name: $x, id: $y})", 
						parameters("x", name, "y", id)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "id already exists\n", 400);
			}
		}
	}
	
	private void addStudioRelation(HttpExchange r, String stdid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: studio {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", stdid)) == null
					|| session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", movid)) == null) {
				sendString(r, "one or both id's don't exist\n", 404);
			}
			if(session.run("RETURN EXISTS( (:studio {id: $x})-[:OWNED_BY]-(:movie {id: $y})", parameters("x", stdid, "y", movid)) != null) {
				session.writeTransaction(tx -> tx.run("MATCH (a:studio {id:$x}),"
						+ "(t:movie {id:$y})\n" + 
						 "MERGE (a)-[r:OWNED_BY]->(t)\n" + 
						 "RETURN r", parameters("x", stdid, "y", movid)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "relationship already exists\n", 400);
			}
		}
	}
	
	private void addRelationship(HttpExchange r, String actid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: actor {id: $y})" + "RETURN a IS NOT NULL", parameters("y", actid)).single().get(0).asBoolean() == false
					|| session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL", parameters("y", movid)).single().get(0).asBoolean() == false) {
				sendString(r, "one or both id's don't exist\n", 404);
			}
			if(session.run("RETURN EXISTS( (:actor {id: $x})-[:ACTED_IN]-(:movie {id: $y})", parameters("x", actid, "y", movid)).single().get(0).asBoolean() == false) {
				session.writeTransaction(tx -> tx.run("MATCH (a:actor {id:$x}),"
						+ "(t:movie {id:$y})\n" + 
						 "MERGE (a)-[r:ACTED_IN]->(t)\n" + 
						 "RETURN r", parameters("x", actid, "y", movid)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "relationship already exists\n", 400);
			}
		}
	}
	
	private void addRatingRelation(HttpExchange r, String ratid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: rating {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", ratid)) == null
					|| session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", movid)) == null) {
				sendString(r, "one or both id's don't exist\n", 404);
			}
			if(session.run("RETURN EXISTS( (:rating {id: $x})-[:AGE_RATED]-(:movie {id: $y})", parameters("x", ratid, "y", movid)) != null) {
				session.writeTransaction(tx -> tx.run("MATCH (a:rating {id:$x}),"
						+ "(t:movie {id:$y})\n" + 
						 "MERGE (a)-[r:AGE_RATED]->(t)\n" + 
						 "RETURN r", parameters("x", ratid, "y", movid)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "relationship already exists\n", 400);
			}
		}
	}
	
	private void addLanguageRelation(HttpExchange r, String langid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: language {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", langid)) == null
					|| session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", movid)) == null) {
				sendString(r, "one or both id's don't exist\n", 404);
			}
			if(session.run("RETURN EXISTS( (:language {id: $x})-[:MAIN_SPEAK]-(:movie {id: $y})", parameters("x", langid, "y", movid)) != null) {
				session.writeTransaction(tx -> tx.run("MATCH (a:language {id:$x}),"
						+ "(t:movie {id:$y})\n" + 
						 "MERGE (a)-[r:MAIN_SPEAK]->(t)\n" + 
						 "RETURN r", parameters("x", langid, "y", movid)));
				session.close();
				sendString(r, "add Successful\n", 200);
			} else {
				sendString(r, "relationship already exists\n", 400);
			}
		}
	}
	
	
	//Methods for all the GET requests
	private void getActor(HttpExchange r, String id) throws IOException{
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: actor {id: $y})" + "RETURN a IS NOT NULL", parameters("y", id)).single().get(0).asBoolean() == true) {
				String movies = session.writeTransaction(tx -> {
					StatementResult result = tx.run("MATCH( (a :actor {id: $x})-[:ACTED_IN]-(m :movie) )\n"
				+"RETURN m.id", parameters("x", id));
					JSONObject body = new JSONObject();
					try {
						body.put("actorId", id);
						StatementResult name = tx.run("MATCH( (a: actor {id: $x}) )" + "RETURN a.name", parameters("x", id));
						body.put("name", name.single().get(0).asString());
						JSONArray list = new JSONArray();
						Record record;
						while(result.hasNext()) {
							record = result.next();
							list.put(record.get("m.id", ""));
						}
						body.put("movie", list);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, movies, 200);
			} else {
				sendString(r,"id does not exist\n", 404);
			}
		}
	}
	
	private void getMovie(HttpExchange r, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) == null) {
				String actors = session.writeTransaction(tx -> {
					StatementResult result = tx.run("MATCH( (a :movie {id: $x})-[:ACTED_IN]-(m :actor) )\n"
				+"RETURN m.id", parameters("x", id));
					JSONObject body = new JSONObject();
					try {
						body.put("movieId", id);
						StatementResult name = tx.run("MATCH( (a: movie {id: $x}) )" + "RETURN a.name", parameters("x", id));
						body.put("name", name.single().get(0).asString());
						JSONArray list = new JSONArray();
						Record record;
						while(result.hasNext()) {
							record = result.next();
							list.put(record.get("m.id", ""));
						}
						body.put("actors", list);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, actors, 200);
			} else {
				sendString(r,"id does not exist\n", 404);
			}
		}
	}

	private void getStudio(HttpExchange r, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: studio {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) == null) {
				String movies = session.writeTransaction(tx -> {
					StatementResult result = tx.run("MATCH( (a :studio {id: $x})-[:OWNED_BY]-(m :movie) )\n"
				+"RETURN m.id", parameters("x", id));
					JSONObject body = new JSONObject();
					try {
						body.put("studioId", id);
						StatementResult name = tx.run("MATCH( (a: studio {id: $x}) )" + "RETURN a.name", parameters("x", id));
						body.put("name", name.single().get(0).asString());
						JSONArray list = new JSONArray();
						Record record;
						while(result.hasNext()) {
							record = result.next();
							list.put(record.get("m.id", ""));
						}
						body.put("movie", list);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, movies, 200);
			} else {
				sendString(r,"id does not exist\n", 404);
			}
		}
	}
	
	private void getRating(HttpExchange r, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: rating {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) == null) {
				String movies = session.writeTransaction(tx -> {
					StatementResult result = tx.run("MATCH( (a :rating {id: $x})-[:ACTED_IN]-(m :movie) )\n"
				+"RETURN m.id", parameters("x", id));
					JSONObject body = new JSONObject();
					try {
						body.put("ratingId", id);
						StatementResult name = tx.run("MATCH( (a: rating {id: $x}) )" + "RETURN a.name", parameters("x", id));
						body.put("name", name.single().get(0).asString());
						JSONArray list = new JSONArray();
						Record record;
						while(result.hasNext()) {
							record = result.next();
							list.put(record.get("m.id", ""));
						}
						body.put("movie", list);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, movies, 200);
			} else {
				sendString(r,"id does not exist\n", 404);
			}
		}
	}
	
	private void getLanguage(HttpExchange r, String id) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: language {id: $y})" + "RETURN a IS NOT NULL AS Predicate", parameters("y", id)) == null) {
				String movies = session.writeTransaction(tx -> {
					StatementResult result = tx.run("MATCH( (a :language {id: $x})-[:ACTED_IN]-(m :movie) )\n"
				+"RETURN m.id", parameters("x", id));
					JSONObject body = new JSONObject();
					try {
						body.put("languageId", id);
						StatementResult name = tx.run("MATCH( (a: language {id: $x}) )" + "RETURN a.name", parameters("x", id));
						body.put("name", name.single().get(0).asString());
						JSONArray list = new JSONArray();
						Record record;
						while(result.hasNext()) {
							record = result.next();
							list.put(record.get("m.id", ""));
						}
						body.put("movie", list);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, movies, 200);
			} else {
				sendString(r,"id does not exist\n", 404);
			}
		}
	}
	
	private void hasRelationship(HttpExchange r, String actid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: actor {id: $y})" + "RETURN a IS NOT NULL", parameters("y", actid)).single().get(0).asBoolean() == true
					&& session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL", parameters("y", movid)).single().get(0).asBoolean() == true) {
				String check = session.writeTransaction(tx -> {
					JSONObject body = new JSONObject();

					try {
						body.put("actorId", (tx.run("MATCH( (a: actor {id: $x) )" + "RETURN a.name",parameters("x", actid))).single().get(0).toString());
						body.put("movieId", (tx.run("MATCH( (a: movie {id: $x) )" + "RETURN a.name",parameters("x", movid))).single().get(0).toString());
						body.put("hasRelationship"
								, (tx.run("RETURN EXISTS( (:actor {id:$x})-[ACTED_IN]-(:movie {id:$y}) )"
										,parameters("x",actid, "y", movid)).single().get(0).asBoolean()));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, check, 200);
			} else {
				sendString(r, "one or both id's don't exist\n", 404);
			}
		}
	}
	
	private void hasStudioRelationship(HttpExchange r, String stdid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: studio {id: $y})" + "RETURN a IS NOT NULL", parameters("y", stdid)).single().get(0).asBoolean() == true
					&& session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL", parameters("y", movid)).single().get(0).asBoolean() == true) {
				String check = session.writeTransaction(tx -> {
					JSONObject body = new JSONObject();

					try {
						body.put("studioId", (tx.run("MATCH( (a: studio {id: $x) )" + "RETURN a.name",parameters("x", stdid))).single().get(0).toString());
						body.put("movieId", (tx.run("MATCH( (a: movie {id: $x) )" + "RETURN a.name",parameters("x", movid))).single().get(0).toString());
						body.put("hasRelationship"
								, (tx.run("RETURN EXISTS( (:studio {id:$x})-[OWNED_BY]-(:movie {id:$y}) )"
										,parameters("x",stdid, "y", movid)).single().get(0).asBoolean()));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, check, 200);
			} else {
				sendString(r, "one or both id's don't exist\n", 404);
			}
		}
	}
	
	private void isRated(HttpExchange r, String ratid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: rating {id: $y})" + "RETURN a IS NOT NULL", parameters("y", ratid)).single().get(0).asBoolean() == true
					&& session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL", parameters("y", movid)).single().get(0).asBoolean() == true) {
				String check = session.writeTransaction(tx -> {
					JSONObject body = new JSONObject();

					try {
						body.put("ratingId", (tx.run("MATCH( (a: actor {id: $x) )" + "RETURN a.name",parameters("x", ratid))).single().get(0).toString());
						body.put("movieId", (tx.run("MATCH( (a: movie {id: $x) )" + "RETURN a.name",parameters("x", movid))).single().get(0).toString());
						body.put("isRated"
								, (tx.run("RETURN EXISTS( (:rating {id:$x})-[AGE_RATED]-(:movie {id:$y}) )"
										,parameters("x",ratid, "y", movid)).single().get(0).asBoolean()));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, check, 200);
			} else {
				sendString(r, "one or both id's don't exist\n", 404);
			}
		}
	}
	
	private void speaksIn(HttpExchange r, String langid, String movid) throws IOException {
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: language {id: $y})" + "RETURN a IS NOT NULL", parameters("y", langid)).single().get(0).asBoolean() == true
					&& session.run("OPTIONAL MATCH (a: movie {id: $y})" + "RETURN a IS NOT NULL", parameters("y", movid)).single().get(0).asBoolean() == true) {
				String check = session.writeTransaction(tx -> {
					JSONObject body = new JSONObject();

					try {
						body.put("languageId", (tx.run("MATCH( (a: language {id: $x) )" + "RETURN a.name",parameters("x", langid))).single().get(0).toString());
						body.put("movieId", (tx.run("MATCH( (a: movie {id: $x) )" + "RETURN a.name",parameters("x", movid))).single().get(0).toString());
						body.put("speaksIn"
								, (tx.run("RETURN EXISTS( (:actor {id:$x})-[MAIN_SPEAK]-(:movie {id:$y}) )"
										,parameters("x",langid, "y", movid)).single().get(0).asBoolean()));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return body.toString();
				});
				sendString(r, check, 200);
			} else {
				sendString(r, "one or both id's don't exist\n", 404);
			}
		}
	}
	
	private String computeBaconPath(HttpExchange r, String id) throws IOException{
		try (Session session = Utils.driver.session()){
			if(session.run("OPTIONAL MATCH (a: actor {id: $y})" + "RETURN a IS NOT NULL", parameters("y", id)).single().get(0).asBoolean() == true) {
				String check = session.writeTransaction(tx -> {
					JSONObject body = new JSONObject();
                    StatementResult result = tx.run(String.format(
                            "MATCH p=shortestPath((a:actor {name: 'Kevin Bacon'})-[r:ACTED_IN*]-(b:actor {id: &x}))" +  "RETURN extract(n IN nodes(p)) AS got",
                            parameters("x", id)));
                    if (result.hasNext()){

						try {
							Record record = result.next();
							List<JSONObject> tmp = new ArrayList<>();
							JSONObject tmp1 = new JSONObject();
							JSONObject tmp2 = new JSONObject();		
							int size = record.get(0).size();
							tmp1.put("actorId", record.get(0).get(0).get("id", ""));
							tmp1.put("movieId", record.get(0).get(1).get("id", ""));
							
							tmp2.put("actorId", record.get(0).get(2).get("id", ""));
							tmp2.put("movieId", record.get(0).get(1).get("id", ""));
	
							tmp.add(tmp1);
	
							for (int i = 3; i < size; i += 2) {
								JSONObject obj = new JSONObject();
								obj.put("actorId", record.get(0).get(i + 1).get("id", ""));
								obj.put("movieId", record.get(0).get(i).get("id", ""));

								tmp.add(obj);
							}
							
							Collections.reverse(tmp);
					
							body.put("baconPath", tmp);
						}catch (Exception e) {
							e.printStackTrace();
						}
				}
                    return body.toString();
				});
				return check;
				}else {
				sendString(r, "Id dousn't exist\n", 404);
			}
		}
		return null;
	}
	
	//Other methods
	private void sendString(HttpExchange request, String data, int restCode) 
			throws IOException {
		request.sendResponseHeaders(restCode, data.length());
        OutputStream os = request.getResponseBody();
        os.write(data.getBytes());
        os.close();
	}

	public void close() {
		Utils.driver.close();
	}

	 private static Map<String, String> splitQuery(String query) throws UnsupportedEncodingException {
	        Map<String, String> query_pairs = new LinkedHashMap<String, String>();
	        String[] pairs = query.split("&");
	        for (String pair : pairs) {
	            int idx = pair.indexOf("=");
	            query_pairs.put(URLDecoder.decode(pair.substring(0, idx), "UTF-8"), URLDecoder.decode(pair.substring(idx + 1), "UTF-8"));
	        }
	        return query_pairs;
	    }
}

