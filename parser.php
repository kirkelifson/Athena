<?

class Parser {
    // team scores
    public $ct_score;
    public $t_score;

    // ct flag
    private $is_ct;

    // player arrays per team
    private $counter_terrorists;
    private $terrorists;

    public function __construct()
    {
        $this->ct_score   = 0;
        $this->t_score    = 0;

        $this->is_ct      = 0;

        $this->counter_terrorists = array();
        $this->terrorists         = array();
    }

    public function read_file($file)
    {
        $ct_counter = 0;
        $t_counter  = 0;

        $log = fopen($file, "r") or die("FILE READ ERROR");

        while (!feof($log))
        {
            $line = fgets($log);

            // Filter Counter-Terrorist team score
            if (preg_match("/COUNTERTERRORIST (.*)/", $line, $matches))
            {
                $this->is_ct    = 1;
                $this->ct_score = $matches[1];
            }

            // Filter Terrorist team score
            elseif (preg_match("/TERRORIST (.*)/", $line, $matches))
            {
                $this->is_ct    = 0;
                $this->t_score  = $matches[1];
            }

            else
            {
                // Fill array containing each player's score
                if (empty($line))
                    break;

                $split  = explode(",", $line);

                $nick   = $split[0];
                $kills  = $split[1];
                $deaths = $split[2];

                if ($this->is_ct)
                    $this->counter_terrorists[$ct_counter++] = array($nick, $kills, $deaths);
                else
                    $this->terrorists[$t_counter++] = array($nick, $kills, $deaths);
            }
        }

        fclose($log);
    }

    public function print_tscore()
    {
        // Print Terrorist team score + player scores
        foreach ($this->terrorists as $t)
        {
            printf("\t<tr>\n");
            printf("\t\t<td>%s</td>\n", $t[0]);
            printf("\t\t<td>%d</td>\n", $t[1]);
            printf("\t\t<td>%d</td>\n", $t[2]);
            printf("\t</tr>\n");
        }
    }

    public function print_ctscore()
    {
        // Print Counter-Terrorist team score + player scores
        foreach ($this->counter_terrorists as $ct)
        {
            printf("\t<tr>\n");
            printf("\t\t<td>%s</td>\n", $ct[0]);
            printf("\t\t<td>%d</td>\n", $ct[1]);
            printf("\t\t<td>%d</td>\n", $ct[2]);
            printf("\t</tr>\n");
        }
    }
}

?>
