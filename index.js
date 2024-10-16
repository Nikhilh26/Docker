const { MongoClient } = require('mongodb');

// MongoDB connection URL (use 'localhost' or appropriate host IP)
const url = 'mongodb://admin:secret@mongodb:27017/my_database?authSource=admin';

// Specify the database name you want to connect to
const dbName = 'your_database_name'; // Replace with your actual database name

const client = new MongoClient(url);

async function connectToDatabase() {
    console.log(dbName);
    console.log(client);
    console.log(url);
    try {
        // Connect to the MongoDB server
        await client.connect();
        console.log("Connected successfully to MongoDB");

        // Select the database
        const db = client.db(dbName);

        // Fetch all collections
        const collections = await db.listCollections().toArray();
        console.log("Collections in the database:", collections);

    } catch (err) {
        console.error("Error connecting to MongoDB:", err);
    } finally {
        // Close the connection
        await client.close();
    }
}

connectToDatabase();
// docker run -d  --name mongodb --network my_network  -p 27017:27017  -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=secret - e MONGO_INITDB_DATABASE=my_database mongo
