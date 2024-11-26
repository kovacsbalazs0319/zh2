<?php
session_start();
require 'db.php';
$db = getDb();
$_SESSION['valami'] = $_GET;
$teherFilter = isset($_GET['teherbiras']) ? intval($_GET['teherbiras']) : 0;

$result = $db->query("SELECT furgon.rendszam as rendszam, ifnull(sum(futar.fizetes),0) as osszfizetes , ifnull(min(futar.fizetes),0) as minfizetes from
futar right outer join furgon on furgon.id = futar.furgon_id where teherbiras > $teherFilter group by furgon.rendszam");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="theme.css"> 
    <title>ZH2</title>
</head>
<body>
    <h1>Név: Kovács Balázs, Neptun kód: E3BJEG</h1>
    
    <?php if($teherFilter < 400): ?>
        <h4>Kisebb mint 400</h4>
    <?php else: ?>
    <table>
        <tr>
           
                <th>Rendszám</th>
                <th>Fizetések összege</th>
                <th>Legkisebb fizetés</th>
           
            <?php while ($row = $result->fetchObject()):?>
                    <tr>
                        <td> <?= $row->rendszam ?> </td>
                        <td> <?= $row->osszfizetes ?> </td>
                        <td> <?= $row->minfizetes ?></td>
                    </tr>                
                <?php endwhile; ?> 
        </tr>
    </table>
    <p>
        <a class="link_text" href="insert.php">Új elem beszúrása</a>
    </p>
    <?php endif ?>
</body>
</html>