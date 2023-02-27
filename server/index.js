const express = require('express');


const mongoose = require('mongoose');

const fileRouter = require("./routes/file");


const PORT = 3000;
const app = express();
const DB = "mongodb+srv://atul:natsuSAMA@cluster2.yjupr0k.mongodb.net/?retryWrites=true&w=majority"



// mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true });
// const db = mongoose.connection;
// db.on('error', console.error.bind(console, 'connection error:'));
// db.once('open', function() {
//   console.log('Connected to MongoDB');
// });
app.use(express.json());
app.use(fileRouter);



mongoose.connect(DB).then(() => {
    console.log('Connection to MongoDB established')
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Coneected to port ${PORT}`);

})



// const Image = mongoose.model('Image', imageSchema);



// app.listen(port, () => {
//   console.log(`Server running on port ${port}`);
// });
