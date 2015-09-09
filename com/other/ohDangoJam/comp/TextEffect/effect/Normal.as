class comp.TextEffect.effect.Normal implements comp.TextEffect.effect.Effect
{
    var mc, textEffect;
    function Normal(mc, textEffect)
    {
        this.mc = mc;
        this.textEffect = textEffect;
    } // End of the function
    function effect()
    {
        mc._visible = true;
        textEffect.soundStart(mc);
        textEffect.endExe(mc);
    } // End of the function
} // End of Class
