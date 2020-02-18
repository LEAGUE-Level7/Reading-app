import de.bezier.data.sql.*;

SQLite database;

void setup() {
  print("Starting");
  size(200, 200);
  database = new SQLite(this, "/Users/league/Desktop/Reading-app/mydatabase.db");
  if (database.connect()) {
   database.query("DELETE FROM user WHERE username == \"rushFan\"");
   database.query("insert into user values(5, \"mihi\", \"Mafia ludo reficere\");");
   database.query("SELECT * FROM user;");
   println("\nUsernames");
   while (database.next()) {
     println(database.getString("username"));
   }
   database.query("SELECT * FROM user;");
   println("\nPasswords");
   while (database.next()) {
    println(database.getString("passwd")); 
   }
  }
  else {
     println("didnt connect"); 
  }
}
