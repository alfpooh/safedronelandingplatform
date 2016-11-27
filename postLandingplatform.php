<?php
// Read request parameters
$Category = $_REQUEST["Category"];
$Name = $_REQUEST["Name"];
$uniqueID =$_REQUEST["uniqueID"];
$latitude = $_REQUEST["latitude"];
$longitude = $_REQUEST["longitude"];
$Comment = $_REQUEST["Comment"];
$Availability = $_REQUEST["Availability"];
$Temperature = $_REQUEST["Temperature"];
$Contact = $_REQUEST["Contact"];

// Store values in an array


$returnValue = array("Category"=>$Category, "Name"=>$Name, "uniqueID"=>$uniqueID, "latitude"=>$latitude, "longitude"=>$longitude, "Comment"=>$Comment, "Availability"=>$Availability, "Temperature"=>$Temperature, "Contact"=>$Contact);

//save local file
$myfile = fopen("dronedata.txt", "w") or die("Unable to open file!");
$txt = $returnValue;
fwrite($myfile, $txt);
fclose($myfile);

// Send back request in JSON format
echo "working"
echo json_encode($returnValue); 

?>
