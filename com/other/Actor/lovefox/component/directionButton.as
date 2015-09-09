package lovefox.component
{
    import flash.display.*;

    class directionButton extends SimpleButton
    {
        var upColor:uint = 14803425;
        var overColor:uint = 15132390;
        var downColor:uint = 13421772;
        var size:uint;
        var way:uint;

        function directionButton(param1, param2)
        {
            this.size = param1;
            this.way = param2;
            downState = new directionButtonDisplayState(this.downColor, param1, param2);
            overState = new directionButtonDisplayState(this.overColor, param1, param2);
            upState = new directionButtonDisplayState(this.upColor, param1, param2);
            hitTestState = new directionButtonDisplayState(this.upColor, param1, param2);
            return;
        }// end function

    }
}
