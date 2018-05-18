<?php
session_start();
$_SESSION['dummy-date'] = time();
?>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8" />
        <title>Request dump | LEMP Test</title>
    </head>

    <body>
        
        <h1>GET</h1>

        <?php foreach ($_GET as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

        <h1>POST</h1>

        <?php foreach ($_POST as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

        <h1>FILES</h1>

        <?php foreach ($_FILES as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

        <h1>REQUEST</h1>

        <?php foreach ($_REQUEST as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

        <h1>SERVER</h1>

        <?php foreach ($_SERVER as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

        <h1>SESSION</h1>

        <?php foreach ($_SESSION as $key => $value) : ?>
            <h4><?php echo $key ?></h4>
            <p><?php var_dump($value) ?></p>
        <?php endforeach ?>

    </body>

</html>