<?php
if (isset($_POST['f_submit'])) {
    require_once("conn.php");
    $ky_code = $_POST['ky_code_new'];
    $pd_code = $_POST['pd_code_new'];
    $jurisdiction_code = $_POST['jurisidiction_code_new'];
    $complaint_num = $_POST['complaint_num_new'];
    $complaint_begin_time= $_POST['complaint_begin_time_new'];
    $query = "CALL insertCrime (ky_code, pd_code, juristiction_code, complaint_begin_time, complaint_num"
            . "VALUES (:ky_code_new, :pd_code_new, :juristiction_code_new,:complaint_begin_time_new, :complaint_num_new)";
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ky_code_new', $ky_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':pd_code_new', $pd_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':juristiction_code_new', $jurisdiction_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':complaint_begin_time_new', $complaint_begin_time, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':complaint_num_new', $complaint_num, PDO::PARAM_INT);
      $result = $prepared_stmt->execute();
    }
    catch (PDOException $ex)
    { // Error in database processing.
    echo $sql . "<br>" . $error->getMessage();
    } // HTTP 500 - Internal Server Error
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
<h1> Insert Crime </h1>
    <form method="post">
      <label for="id_ky_code">ky_code</label>
      <input type="text" name="f_ky_code" id="id_ky_code">
    	<label for="id_pd_code">pd_code</label>
    	<input type="text" name="f_pd_code" id="id_pd_code">
    	<label for="id_jurisidiction_code">jurisidiction_code</label>
    	<input type="text" name="f_jurisidiction_code" id="id_jurisidiction_code">
      <label for="id_complaint_begin_time">complaint begin time</label>
    	<input type="text" name="f_complaint_begin_time" id="id_complaint_begin_time">
    	<label for="id_complaint_num">complaint_num</label>
    	<input type="text" name="f_complaint_num" id="id_complaint_num">
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
