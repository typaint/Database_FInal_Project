<?php
if (isset($_POST['f_submit'])) {
    require_once("conn.php");
    $var_ky_code = $_POST['f_ky_code'];
    $var_pd_code = $_POST['f_pd_code'];
    $var_jurisdiction_code = $_POST['f_jurisdiction_code'];
    $var_complaint_num = $_POST['f_complaint_num'];
    $var_begin_time_new = $_POST['f_begin_time_new'];
    $query = "CALL insertCrime (:ky_code, :pd_code, :jurisdiction_code,
    :complaint_num, :begin_time_new)";
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ky_code', $var_ky_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':pd_code', $var_pd_code, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':jurisdiction_code', $var_jurisdiction_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':complaint_num', $var_complaint_num, PDO::PARAM_STR);
      $prepared_stmt->bindValue(':begin_time_new', $var_begin_time_new, PDO::PARAM_STR);
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
<h1> Add Crime </h1>
    <form method="post">
    	<label for="id_ky_code">ky code</label>
    	<input type="text" name="f_ky_code" id="id_ky_code">
    	<label for="id_pd_code">pd code</label>
    	<input type="text" name="f_pd_code" id="id_pd_code">
    	<label for="id_jurisdiction_code">jurisdiction code</label>
    	<input type="text" name="f_jurisdiction_code" id="id_jurisdiction_code">
    	<label for="id_complaint_num">complaint num</label>
    	<input type="text" name="f_complaint_num" id="id_complaint_num">
      <label for="id_begin_time_new">complaint begin time</label>
    	<input type="text" name="f_begin_time_new" id="id_begin_time_new">
    	<input type="submit" name="f_submit" value="Submit">
    </form>
    <?php
      if (isset($_POST['f_submit'])) {
        if ($result) {
    ?>
          Crime data was inserted successfully.
    <?php
        } else {
    ?>
          <h3> Sorry, there was an error. Crime data was not inserted. </h3>
    <?php
        }
      }
    ?>
  </body>
</html>
