<?php
    session_start();
    require 'db.php';
    $param = $_SESSION['valami'] ?? [];
    $rendszam='';
    $sebesseg='';

    if (isset($_POST['uj'])) {
        $rendszam=$_POST['rendszam'];
        $sebesseg= filter_var($_POST['sebesseg'], FILTER_VALIDATE_INT);
    if (strlen($rendszam)==7) {
        try {
            $db=getDb();
            $insertStatement = $db->prepare("INSERT INTO motor(rendszam, sebesseg) VALUES (:rendszam, :sebesseg)");
            $insertStatement->bindParam(':rendszam',$rendszam, PDO::PARAM_STR);
            $insertStatement->bindParam(':sebesseg',$sebesség, PDO::PARAM_INT);
            $insertStatement->execute();
        if (!empty($param)) {
            $redirectURL = 'index.php';
            $redirectURL.= '?' . http_build_query($param);
            header("Location: $redirectURL");
        }
        exit();
        } catch (PDOException $e) {
            echo 'nem jó' . $e->getMessage();
        }    
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
        <form action="insert.php" method="post">
            <h1>Új motor</h1>
            <p>
                <label> Rendszám: <input type="text" name="rendszam" value="<?php echo $rendszam ?>"></label>
            </p>
            <p>
                <label> Sebesség: <input type="text" name="sebesseg" value="<?php echo $sebesseg ?>"></label>
            </p>
            <p> 
                <input type="submit" value="Elküld" name="uj" />
            </p>
        </form>
</body>
</html>