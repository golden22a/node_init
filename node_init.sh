#!/bin/bash
#on script for making node projects
if [ $1 != '-g' ];  then
echo "creating new project ";
mkdir  $1
echo "making basinc structer /views && /models"
mkdir -p  "$1/views" "$1/views/scripts" "$1/views/styles" "$1/models"
echo "creating models/index.js"
echo "var mongoose = require('mongoose');


/*add you connection somewhere here*/
mongoose.connect('mongodb://localhost/$1', {promiseLibrary: global.Promise});


">> "$1/models/index.js"
echo "creating script and style"
touch "$1/views/scripts/app.js"
touch "$1/views/styles/style.css"
echo "server .js"
touch "$1/server.js"
echo "json package"
touch "$1/package.json"
echo '{
  "name": "'$1'",
  "version": "1.0.0",
  "description": "",
  "main": "server.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.16.2",
    "mongoose": "^5.0.9",
    "nodemon": "^1.17.1",
    "body-parser": "^1.18.2"
  }
}'>> "$1/package.json";

#then the rest of the files
echo 'basic server.js';
echo "var express=require('express');
var app=express();
var db=require('./models/index.js');
app.get('/',function(req,res){
  console.log('do you stuff here')
  });


app.listen(3000,function(){
  console.log('server running');
});" >> "$1/server.js";
eval "cd $1/ && npm install"
echo "node_modules" >> ".gitignore"
eval "git init && git add -A && git commit -m 'initialized project $1'"
echo "project created run cd $1 no need to run npm isntall i already did that for you";
elif [ $1 == '-g' ]; then
  model=${2^}
  myArray=(${@:3})
  a=${@: -1}
unset myArray[${#myArray[@]}-1]

  echo 'creating module'
  echo "var mongoose = require('mongoose');
var Schema = mongoose.Schema;

"$model"Schema = new Schema({" >> "models/$model.js"

  for arg in "${myArray[@]}"; do
     echo "$arg:String," >> "models/$model.js"
  done
  echo "$a:String" >> "models/$model.js"
  echo "});

var $model = mongoose.model('$model', $model);
module.exports = $model;
" >> "models/$model.js"
echo "module.exports = {
    $model: $model
};">> 'models/index.js';
else
echo 'wrong entry'

fi
