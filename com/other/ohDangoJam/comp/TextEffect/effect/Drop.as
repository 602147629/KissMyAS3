class comp.TextEffect.effect.Drop implements comp.TextEffect.effect.Effect
{
    var mc, textEffect, scope;
    function Drop(mc, textEffect)
    {
        this.mc = mc;
        this.textEffect = textEffect;
    } // End of the function
    function effect()
    {
        mc._y = FIRST_Y_POS;
        mc._visible = true;
        mc._alpha = 50;
        mc.scope = this;
        mc.onEnterFrame = move;
    } // End of the function
    function move()
    {
        this = scope;
        mc._y = mc._y + speed;
        mc._alpha = mc._alpha + 20;
        speed = speed * PLUS_SPEED;
        if (mc._y < 0)
        {
            return;
        } // end if
        mc._y = 0;
        mc._alpha = 100;
        delete mc.onEnterFrame;
        textEffect.soundStart(mc);
        textEffect.endExe(mc);
    } // End of the function
    var FIRST_Y_POS = -5;
    var PLUS_SPEED = 1.200000;
    var speed = 1;
} // End of Class
