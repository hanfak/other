var express = require('express');
var mongoose  = require("./db/connection");
var bodyParser = require('body-parser');

var app = express();
var fs = require("fs");

var Contact = mongoose.model("Contact");

var person1 = {
  name: 'person 1 name',
  email: 'person1@email.com',
  number: '111 111 1111'
};

var person2 = {
  name: 'person 2 name',
  email: 'person2@email.com',
  number: '222 222 2222'
};

var person3 = {
  name: 'person 3 name',
  email: 'person3@email.com',
  number: '333 333 3333'
};

var contactList = [person1, person2, person3];

app.use(express.static(__dirname + "/public"));
app.use(bodyParser.json());


app.get('/var', function(req,res) {
  console.log('Received GET request');
  res.json(contactList);
});

app.get('/file', function(req, res) {
  var contents = fs.readFileSync("foo.txt");
  var jsonContent = JSON.parse(contents);
  res.json(jsonContent);
});

app.get('/db', function(req, res) {
  Contact.find().then(function(contacts){
    console.log(contacts);
    res.json(contacts);
  });
});

app.post('/db', function(req, res){
  console.log('where is th contact ' + req.body);
  Contact.create(req.body).then(function(one_contact){
    res.json(one_contact);
  });
});

app.delete('/db/:id', function(req, res){
  console.log('where is the contact ' + req.params.id);
  Contact.findByIdAndRemove(req.params.id).then(function(){
    res.json({success: true});
  });
});

app.listen(3000);
console.log('server running');
