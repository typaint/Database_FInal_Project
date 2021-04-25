<?php
if (isset($_POST['f_submit'])) {
    require_once("conn.php");
    $var_complaint_num = $_POST['f_complaint_num'];
    $var_end_time_new = $_POST['f_end_time_new'];
    $var_end_date_new = $_POST['f_end_date_new'];
    $query = "CALL updateCrime (:complaint_num,end_time_new,end_date_new)";
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':complaint_num', $var_complaint_num, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':end_time_new', $var_begin_date_new, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':end_date_new', $var_begin_date_new, PDO::PARAM_STR);
      $result = $prepared_stmt->execute();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>
<html>
  <head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head>
  <body>
    <div id="navbar">
      <ul>
        <li><a href="index.html">Home</a></li>
      </ul>
    </div>
<h1> Update Crime </h1>
    <form method="post">
    	<label for="id_complaint_num">complaint num</label>
    	<input type="text" name="f_complaint_num" id="id_complaint_num">
      <label for="id_begin_time_new">complaint end time</label>
      <input type="text" name="f_end_time_new" id="id_end_time_new">
      <label for="id_end_date_new">complaint end date</label>
      <input type="text" name="f_end_date_new" id="id_end_date_new">
    	<input type="submit" name="f_submit" value="Submit">
    </form>
    <?php
      if (isset($_POST['f_submit'])) {
        if ($result) {
    ?>
          Crime data was updated successfully.
    <?php
        } else {
    ?>
          <h3> Sorry, there was an error. Crime data was not updated. </h3>
    <?php
        }
      }
    ?>
  </body>
</html>
