class pjam.fight.Effect
{
    var root, scene, effectMC, _currentframe, _totalframes;
    function Effect(root)
    {
        this.root = root;
        scene = root.stageMC.fightMC;
    } // End of the function
    function char(list, mc)
    {
        effectMC.removeMovieClip();
        effectMC = mc.createEmptyMovieClip("effectMC", mc.getNextHighestDepth());
        var sc = this;
        var count = 0;
        effectMC.onEnterFrame = function ()
        {
            var _loc1 = new Color(mc);
            _loc1.setTransform(list[count]);
            if (++count >= list.length)
            {
                sc.effectMC.removeMovieClip();
            } // end if
        };
    } // End of the function
    function damage(hit, mc, vec)
    {
        var _loc4 = scene.getNextHighestDepth();
        var _loc2 = scene.attachMovie("damageMC", "damageMC" + _loc4, _loc4);
        _loc2._x = mc._x + vec * (mc._width / 2);
        _loc2._y = mc._y - mc._height / 2;
        _loc2.gotoAndStop(hit);
        this.sound("damage_" + hit);
        this.watchEffect(_loc2.mc, _loc2);
    } // End of the function
    function jump(mc, vecStr)
    {
        var _loc3 = scene.backEffectMC;
        var _loc4 = _loc3.getNextHighestDepth();
        var _loc2 = _loc3.attachMovie("jumpMC", "jumpMC" + _loc4, _loc4);
        _loc2._x = mc._x;
        _loc2._y = mc._y;
        _loc2.gotoAndStop(vecStr);
        this.watchEffect(_loc2.mc, _loc2);
    } // End of the function
    function aerial(mc)
    {
        var _loc4 = scene.frontEffectMC;
        var _loc3 = scene.getNextHighestDepth();
        var _loc2 = _loc4.attachMovie("aerialMC", "aerialMC" + _loc3, _loc3);
        _loc2._x = mc._x;
        _loc2._y = mc._y;
        this.watchEffect(_loc2, _loc2);
    } // End of the function
    function power(mc, vec)
    {
        this.effectCmn(mc, vec, "powerMC", "", 0, pjam.fight.Effect.POWER, "power");
    } // End of the function
    function defense(mc, vec)
    {
        this.effectCmn(mc, vec, "defenseMC", "CHANSE!", 16759671, pjam.fight.Effect.DEFENSE, "defense");
    } // End of the function
    function smash(mc, vec)
    {
        this.effectCmn(mc, vec, "smashMC", "SMAAASH!!", 4508740, pjam.fight.Effect.SMASH, "smash");
    } // End of the function
    function effectCmn(mc, vec, id, str, color, efList, soundID)
    {
        var _loc4 = scene.backEffectMC;
        var _loc5 = _loc4.getNextHighestDepth();
        var _loc2 = _loc4.attachMovie(id, id + _loc5, _loc5);
        _loc2._x = mc._x;
        _loc2._y = mc._y - mc._height / 2;
        _loc2.gotoAndStop(vec);
        if (str != "")
        {
            var _loc6 = new pjam.fight.TextEffect(root, scene);
            _loc6.start(str, mc, color, pjam.fight.TextEffect.DAMAGE_MODE);
        } // end if
        if (efList != null)
        {
            this.char(efList, mc);
        } // end if
        if (soundID != "")
        {
            this.sound(soundID);
        } // end if
        this.watchEffect(_loc2.mc, _loc2);
    } // End of the function
    function sound(id)
    {
        var _loc2 = new Sound(root);
        _loc2.attachSound(id);
        _loc2.start();
    } // End of the function
    function watchEffect(mc1, mc2)
    {
        var _loc2 = this;
        mc1.onEnterFrame = function ()
        {
            if (_currentframe == _totalframes)
            {
                mc2.removeMovieClip();
            } // end if
        };
    } // End of the function
    static var DAMAGE = [{ra: 30, rb: 180, ga: 30, gb: 100, ba: 30, bb: 100, aa: 100, ab: 0}, {ra: 30, rb: 180, ga: 30, gb: 100, ba: 30, bb: 100, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: -170, ba: 100, bb: -220, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: -170, ba: 100, bb: -220, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: -170, ba: 100, bb: -220, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: -100, ba: 100, bb: -100, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: -50, ba: 100, bb: -50, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0}];
    static var POWER = [{ra: 30, rb: 100, ga: 30, gb: 100, ba: 30, bb: 180, aa: 100, ab: 0}, {ra: 30, rb: 100, ga: 30, gb: 100, ba: 30, bb: 180, aa: 100, ab: 0}, {ra: 30, rb: 100, ga: 30, gb: 100, ba: 30, bb: 180, aa: 100, ab: 0}, {ra: 100, rb: -120, ga: 100, gb: -120, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -120, ga: 100, gb: -120, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -120, ga: 100, gb: -120, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -120, ga: 100, gb: -120, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -90, ga: 100, gb: -90, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -60, ga: 100, gb: -60, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: -40, ga: 100, gb: -40, ba: 100, bb: 0, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0}];
    static var DEFENSE = [{ra: 30, rb: 200, ga: 30, gb: 140, ba: 30, bb: -30, aa: 100, ab: 0}, {ra: 30, rb: 200, ga: 30, gb: 140, ba: 30, bb: -30, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 28, ga: 100, gb: -60, ba: 100, bb: -155, aa: 100, ab: 0}, {ra: 100, rb: 10, ga: 100, gb: -30, ba: 100, bb: -55, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0}];
    static var SMASH = [{ra: 30, rb: 200, ga: 65, gb: 140, ba: 30, bb: -30, aa: 100, ab: 0}, {ra: 30, rb: 200, ga: 65, gb: 140, ba: 30, bb: -30, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 40, ga: 100, gb: -90, ba: 100, bb: -255, aa: 100, ab: 0}, {ra: 100, rb: 28, ga: 100, gb: -60, ba: 100, bb: -155, aa: 100, ab: 0}, {ra: 100, rb: 10, ga: 100, gb: -30, ba: 100, bb: -55, aa: 100, ab: 0}, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0}];
} // End of Class
