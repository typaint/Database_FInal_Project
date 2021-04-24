<?php
if (isset($_POST['f_submit'])) {
    require_once("conn.php");
    $var_ky_code = $_POST['ky_code_new'];
    $var_pd_code = $_POST['pd_code_new'];
    $var_jurisdiction_code = $_POST['jurisidiction_code_new'];
    $var_complaint_num = $_POST['complaint_num_new'];
    $var_vic = $_POST['vic_sex_new'];
    $var_sus = $_POST['sus_sex_new'];
    $query = "INSERT INTO complaint_info(ky_code, pd_code, juristiction_code, complaint_num, victim_sex, suspect_sex) "
            . "VALUES (:ky_code_new, :pd_code_new, :juristiction_code_new, :complaint_num_new, :vic_sex_new, sus_sex_new)";
    try
    {
      $prepared_stmt = $dbo->prepare($query);
      $prepared_stmt->bindValue(':ky_code_new', $ky_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':pd_code_new', $pd_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':juristiction_code_new', $jurisdiction_code, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':complaint_num_new', $complaint_num, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':vic_sex_new', $victim_num, PDO::PARAM_INT);
      $prepared_stmt->bindValue(':sus_sex_new', $suspect_sex, PDO::PARAM_INT);
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
        <li><a href="getCrime.php">Search Crime</a></li>
        <li><a href="insertCrime.php">Insert Crime</a></li>
        <li><a href="deleteCrime.php">Delete Crime</a></li>
      </ul>
    </div>
<h1> Insert Movie </h1>
    <form method="post">
      <label for="id_ky_code">ky_code</label>
      <input type="text" name="f_ky_code" id="id_ky_code">
    	<label for="id_pd_code">pd_code</label>
    	<input type="text" name="f_pd_code" id="id_pd_code">
    	<label for="id_jurisidiction_code">jurisidiction_code</label>
    	<input type="text" name="f_jurisidiction_code" id="id_jurisidiction_code">
    	<label for="id_complaint_num">complaint_num</label>
    	<input type="text" name="f_complaint_num" id="id_complaint_num">
      <label for="id_victim_sex">victim_sex</label>
    	<input type="text" name="f_victim_sex" id="id_victim_sex">
      <label for="id_suspect_sex">suspect_sex</label>
    	<input type="text" name="f_suspect_sex" id="id_suspect_sex">
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
