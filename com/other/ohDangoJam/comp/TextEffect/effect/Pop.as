class comp.TextEffect.effect.Pop implements comp.TextEffect.effect.Effect
{
    var mc, textEffect, _yscale, _y, onEnterFrame;
    function Pop(mc, textEffect)
    {
        this.mc = mc;
        this.textEffect = textEffect;
    } // End of the function
    function effect()
    {
        mc._yscale = 0;
        mc._visible = true;
        var sc = this;
        var step = 0;
        mc.onEnterFrame = function ()
        {
            _yscale = sc.LIST[step].h;
            _y = sc.LIST[step].y;
            if (++step <= sc.LIST.length)
            {
                return;
            } // end if
            _yscale = 100;
            delete this.onEnterFrame;
            sc.textEffect.soundStart(this);
            sc.textEffect.endExe(this);
        };
    } // End of the function
    var UP = 0.800000;
    var DOWN = 1.200000;
    var STEP = 5;
    var LIST = [{h: 30, y: 0}, {h: 62, y: -5}, {h: 87, y: -9}, {h: 130, y: -10}, {h: 145, y: -9}, {h: 123, y: -7}, {h: 100, y: 0}];
} // End of Class
