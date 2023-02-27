const mongoose = require("mongoose");

const fileSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description : {
    type : String,
    required : true,
    trim : true,
  },

  files : 
    {
      type : String,
      required : true
    }
  

});

const Files = mongoose.model("Files", fileSchema);
module.exports = { Files, fileSchema };