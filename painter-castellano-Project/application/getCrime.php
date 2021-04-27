<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['field_submit'])) {
    // Refer to conn.php file and open a connection.
    require_once("conn.php");
    // Will get the value typed in the form text field and save into variable
    $var_complaint_num = $_POST['field_complaint_num'];
    // Save the query into variable called $query. Note that :ph_complaint_num is a place holder
    $query = "CALL searchCrime(:complaint_num)";

try
    {
      // Create a prepared statement. Prepared statements are a way to eliminate SQL INJECTION.
      $prepared_stmt = $dbo->prepare($query);
      //bind the value saved in the variable $var_complaint_num to the place holder :ph_complaint_num
      // Use PDO::PARAM_STR to sanitize user string.
      $prepared_stmt->bindValue(':complaint_num', $var_complaint_num, PDO::PARAM_STR);
      $prepared_stmt->execute();
      // Fetch all the values based on query and save that to variable $result
      $result = $prepared_stmt->fetchAll();

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>

<html>
<!-- Any thing inside the HEAD tags are not visible on page.-->
  <head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head>
<!-- Everything inside the BODY tags are visible on page.-->
  <body>
    <div id="navbar">
      <ul>
        <li><a href="index.html">Home</a></li>
      </ul>
    </div>

    <h1> Search Crime </h1>
    <!-- This is the start of the form. This form has one text field and one button.
      See the project.css file to note how form is stylized.-->
    <form method="post">

      <label for="id_complaint_num">Complaint Number</label>
      <!-- The input type is a text field. Note the name and id. The name attribute
        is referred above on line 7. $var_complaint_num = $_POST['field_complaint_num']; id attribute is referred in label tag above on line 52-->
      <input type="text" name="field_complaint_num" id = "id_complaint_num">
      <!-- The input type is a submit button. Note the name and value. The value attribute decides what will be dispalyed on Button. In this case the button shows Submit.
      The name attribute is referred  on line 3 and line 61. -->
      <input type="submit" name="field_submit" value="Submit">
    </form>

    <?php
      if (isset($_POST['field_submit'])) {
        // If the query executed (result is true) and the row count returned from the query is greater than 0 then...
        if ($result && $prepared_stmt->rowCount() > 0) { ?>
              <!-- first show the header RESULT -->
              <h2>Results</h2>
              <!-- THen create a table like structure. See the project.css how table is stylized. -->
              <table>
                <!-- Create the first row of table as table head (thead). -->
                <thead>
                   <!-- The top row is table head with four columns named -- ID, Title ... -->
                  <tr>
                    <th>Complaint Number</th>
                    <th>Suspect Sex</th>
                    <th>Suspect Age</th>
                    <th>Suspect Race</th>
                    <th>Offense Description</th>
                    <th>End Date</th>
                    <th>End Time</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                   <!-- For each row saved in the $result variable ... -->
                  <?php foreach ($result as $row) { ?>

                    <tr>
                       <!-- Print (echo) the value of mID in first column of table -->
                      <td><?php echo $row["complaint_num"]; ?></td>
                      <td><?php echo $row["suspect_sex"]; ?></td>
                      <td><?php echo $row["suspect_age_group"]; ?></td>
                      <td><?php echo $row["suspect_race"]; ?></td>
                      <td><?php echo $row["offense_desc"]; ?></td>
                      <td><?php echo $row["complaint_end_date"]; ?></td>
                      <td><?php echo $row["complaint_end_time"]; ?></td>
                    <!-- End first row. Note this will repeat for each row in the $result variable-->
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

        <?php } else { ?>
          <!-- IF query execution resulted in error display the following message-->
          <h3>Sorry, no results found for complaint number <?php echo $_POST['complaint_num']; ?>. </h3>
        <?php }
    } ?>



  </body>
</html>
