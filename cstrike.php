<!DOCTYPE html>
<html>
<head>
  <title>LIVE SCOREBOARD - MATCH</title>
  <link rel="stylesheet" type="text/css" href="score-style.css" />
</head>
<body>
  <script type="text/javascript">
  setTimeout('window.location.href=window.location.href;', 5000);
  </script>
  <?
  $file = "test.log";
  $log = fopen($file, 'r') or die("FILE READ ERROR");
  $ct_score = 0;
  $t_score  = 0;

  $is_ct  = 0;
  $is_t   = 0;

  $gCounter_ct  = 0;
  $gCounter_t   = 0;

  $CounterTerrorists=array();
  $Terrorists=array();

  while (!feof($log))
  {
    $line = fgets($log);
    if (preg_match("/COUNTERTERRORIST (.*)/", $line, $matches))
    {
      $is_ct  = 1;
      $is_t   = 0;
      $ct_score=$matches[1];
    }
    elseif (preg_match("/TERRORIST (.*)/", $line, $matches))
    {
      $is_ct  = 0;
      $is_t   = 1;
      $t_score=$matches[1];
    }
    else
    {
      $split  = explode(",",$line);
      $nick   = $split[0];
      $kills  = $split[1];
      $deaths = $split[2];
      if ($is_ct)
        $CounterTerrorists[$gCounter_ct++]=array($nick,$kills,$deaths);
      else
        $Terrorists[$gCounter_t++]=array($nick,$kills,$deaths);
    }
  }
  fclose($log);
  ?>
  <table border='0'>
  <tr><td><u>Counter-Terrorists</u></td><td><span style="color: green"><? echo $ct_score ?></span></td></tr>
  <tr><td>Player</td><td>Kills</td><td>Deaths</td></tr>
  <?
  foreach ($CounterTerrorists as $ct)
  {
    printf("\t<tr>\n");
    printf("\t<td>%s</td><td>%d</td><td>%d</td>\n",$ct[0],$ct[1],$ct[2]);
    printf("\t</tr>\n");
  }
  ?>
  <tr><td height="50px"></td></tr>
  <tr><td><u>Terrorists</u></td><td><span style="color: red"><? echo $t_score ?></span></td></tr>
  <tr><td>Player</td><td>Kills</td><td>Deaths</td></tr>
  <?
  foreach ($Terrorists as $t)
  {
    printf("\t<tr>\n");
    printf("\t<td>%s</td><td>%d</td><td>%d</td>\n",$t[0],$t[1],$t[2]);
    printf("\t</tr>\n");
  }
  ?>
  </table>
</body>
</html>