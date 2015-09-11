class pjam.head.SoundControl
{
    var root, scene, sound;
    function SoundControl(root)
    {
        this.root = root;
        scene = root.musicMC;
        sound = new Sound(root.bgmMC);
        scene.dummyBtn.useHandCursor = false;
    } // End of the function
    function playSound(id)
    {
        sound.stop();
        sound.attachSound(id);
        sound.start(0, 10000);
    } // End of the function
    function dispControl()
    {
        scene._visible = true;
        root.closeBtn._visible = true;
        var sc = this;
        root.closeBtn.onPress = function ()
        {
            sc.root.closeBtn._visible = false;
            sc.scene._visible = false;
        };
        scene.okBtn.onPress = root.closeBtn.onPress;
        var bar = sc.scene.barBtn;
        var len = scene.maxMC._x - scene.minMC._x;
        bar._x = Math.floor(len * sound.getVolume() / 100) + scene.minMC._x;
        bar.onPress = function ()
        {
            sc.scene.onEnterFrame = function ()
            {
                bar._x = sc.scene._xmouse;
                if (bar._x > sc.scene.maxMC._x)
                {
                    bar._x = sc.scene.maxMC._x;
                } // end if
                if (bar._x < sc.scene.minMC._x)
                {
                    bar._x = sc.scene.minMC._x;
                } // end if
                var _loc1 = (bar._x - sc.scene.minMC._x) * 100 / len;
                sc.sound.setVolume(_loc1);
            };
        };
        bar.onRelease = function ()
        {
            delete sc.scene.onEnterFrame;
        };
        bar.onReleaseOutside = bar.onRelease;
    } // End of the function
} // End of Class
