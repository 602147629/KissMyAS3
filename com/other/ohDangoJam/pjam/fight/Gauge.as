class pjam.fight.Gauge
{
    var root, scene, hpBar, hpMax0, hpMax1, spBar0, spBar1;
    function Gauge(root, php, ehp, sp)
    {
        this.root = root;
        scene = root.stageMC.fightMC;
        hpBar = scene.gaugeMC0.hpMC._width;
        hpMax0 = php;
        hpMax1 = ehp;
        spBar0 = scene.gaugeMC0.spMC0._width;
        spBar1 = scene.gaugeMC0.spMC1._width;
        this.setSP(sp, pjam.fight.player.Player.PLAYER_MY);
        this.setSP(0, pjam.fight.player.Player.PLAYER_EN);
    } // End of the function
    function setHP(hp, num)
    {
        var _loc2 = hpBar * hp / this["hpMax" + num];
        scene["gaugeMC" + num].hpMC._width = _loc2;
    } // End of the function
    function setSP(sp, num)
    {
        var _loc2 = scene["gaugeMC" + num];
        var _loc4 = scene["numTxt" + num];
        if (sp < 50)
        {
            _loc2.spMC0._width = spBar0 * sp / 50;
            _loc2.spMC1._width = 0;
            _loc4.text = "0";
        }
        else
        {
            _loc2.spMC0._width = spBar0;
            _loc2.spMC1._width = spBar1 * (sp - 50) / 50;
            _loc4.text = sp < 100 ? ("1") : ("2");
        } // end else if
    } // End of the function
} // End of Class
