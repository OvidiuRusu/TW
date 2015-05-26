<?php   
if(isset($_POST['submit'])){
        if(move_uploaded_file ($_FILES['uploadFile']['tmp_name'], "uploads/{$_FILES['uploadFile']['name']}")){
			print "Upload reusit.";
		}
		else{
			print "Upload nereusit.";
		}
  }
 ?>