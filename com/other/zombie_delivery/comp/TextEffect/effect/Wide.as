class comp.TextEffect.effect.Wide implements comp.TextEffect.effect.Effect
{
    var mc, textEffect, scope;
    function Wide(mc, textEffect)
    {
        this.mc = mc;
        this.textEffect = textEffect;
    } // End of the function
    function effect()
    {
        mc._yscale = 0;
        mc._visible = true;
        mc.scope = this;
        mc.onEnterFrame = move;
    } // End of the function
    function move()
    {
        this = scope;
        mc._yscale = mc._yscale + 20;
        if (mc._yscale < 100)
        {
            return;
        } // end if
        mc._yscale = 100;
        delete mc.onEnterFrame;
        textEffect.soundStart(mc);
        textEffect.endExe(mc);
    } // End of the function
} // End of Class
