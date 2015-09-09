class pjam.fight.player.Manual
{
    var root, scene, keyLsnr, musLsnr;
    function Manual(root, scene)
    {
        this.root = root;
        this.scene = scene;
        keyLsnr = new Object();
        musLsnr = new Object();
    } // End of the function
    function setControl()
    {
        this.setKey();
        this.setMouse();
    } // End of the function
    function removeControl()
    {
        Key.removeListener(keyLsnr);
        Mouse.removeListener(musLsnr);
    } // End of the function
    function setCanselKey()
    {
        var sc = this;
        keyLsnr.onKeyDown = function ()
        {
            if (Key.getCode() != 38)
            {
                return;
            } // end if
            sc.setControl();
            sc.jump();
        };
        musLsnr.onMouseDown = function ()
        {
            sc.setControl();
            sc.jump();
        };
        Key.addListener(keyLsnr);
        Mouse.addListener(musLsnr);
    } // End of the function
    function setKey()
    {
        var sc = this;
        keyLsnr.onKeyDown = function ()
        {
            if (Key.getCode() == 37)
            {
                sc.move(-1);
            }
            else if (Key.getCode() == 39)
            {
                sc.move(1);
            }
            else if (Key.getCode() == 38)
            {
                sc.jump();
            }
            else if (Key.getCode() == 90)
            {
                sc.action(pjam.fight.player.Player.ATTACK_STATE);
            }
            else if (Key.getCode() == 65)
            {
                sc.action(pjam.fight.player.Player.ATTACK_STATE);
            }
            else if (Key.getCode() == 88)
            {
                sc.action(pjam.fight.player.Player.MAGIC_STATE);
            }
            else if (Key.getCode() == 83)
            {
                sc.action(pjam.fight.player.Player.MAGIC_STATE);
            }
            else if (Key.getCode() == 67)
            {
                sc.action(pjam.fight.player.Player.DEFENSE_STATE);
            }
            else if (Key.getCode() == 68)
            {
                sc.action(pjam.fight.player.Player.DEFENSE_STATE);
            }
            else if (Key.getCode() == 32)
            {
                sc.action(pjam.fight.player.Player.POWER_STATE);
            } // end else if
        };
        Key.addListener(keyLsnr);
    } // End of the function
    function setMouse()
    {
        var sc = this;
        musLsnr.onMouseMove = function ()
        {
            if (sc.scene.mouseMC.hitTest(sc.root._xmouse, sc.root._ymouse, true))
            {
                sc.moveMouse();
            } // end if
        };
        musLsnr.onMouseDown = function ()
        {
            if (sc.scene.mouseMC.hitTest(sc.root._xmouse, sc.root._ymouse, true))
            {
                sc.jump();
            } // end if
        };
        Mouse.addListener(musLsnr);
    } // End of the function
} // End of Class
