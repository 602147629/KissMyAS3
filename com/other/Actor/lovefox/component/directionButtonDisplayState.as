package lovefox.component
{
    import flash.display.*;

    class directionButtonDisplayState extends Shape
    {
        var bgColor:uint;
        var size:uint;
        var way:uint;

        function directionButtonDisplayState(param1:uint, param2:uint, param3:uint)
        {
            this.bgColor = param1;
            this.size = param2;
            this.way = param3;
            this.draw();
            return;
        }// end function

        private function draw() : void
        {
            graphics.beginFill(this.bgColor);
            graphics.drawRect(0, 0, this.size, this.size);
            graphics.endFill();
            graphics.beginFill(16777215, 0.4);
            if (this.way == 1)
            {
                graphics.drawRect(0, 0, this.size, this.size / 2);
                graphics.endFill();
            }
            else if (this.way == 2)
            {
                graphics.drawRect(0, this.size / 2, this.size, this.size / 2);
                graphics.endFill();
            }
            else if (this.way == 3)
            {
                graphics.drawRect(0, 0, this.size / 2, this.size);
                graphics.endFill();
            }
            else if (this.way == 4)
            {
                graphics.drawRect(this.size / 2, 0, this.size / 2, this.size);
                graphics.endFill();
            }
            graphics.beginFill(0);
            graphics.lineStyle(1, this.bgColor, 0, true);
            if (this.way == 1)
            {
                graphics.moveTo(this.size / 2, this.size / 2 - this.size / 4);
                graphics.lineTo(this.size / 2 + this.size / 4, this.size / 2 + this.size / 4);
                graphics.lineTo(this.size / 2 - this.size / 4, this.size / 2 + this.size / 4);
                graphics.lineTo(this.size / 2, this.size / 2 - this.size / 4);
            }
            else if (this.way == 2)
            {
                graphics.moveTo(this.size / 2, this.size / 2 + this.size / 4);
                graphics.lineTo(this.size / 2 + this.size / 4, this.size / 2 - this.size / 4);
                graphics.lineTo(this.size / 2 - this.size / 4, this.size / 2 - this.size / 4);
                graphics.lineTo(this.size / 2, this.size / 2 + this.size / 4);
            }
            else if (this.way == 3)
            {
                graphics.moveTo(this.size / 2 - this.size / 4, this.size / 2);
                graphics.lineTo(this.size / 2 + this.size / 4, this.size / 2 - this.size / 4);
                graphics.lineTo(this.size / 2 + this.size / 4, this.size / 2 + this.size / 4);
                graphics.lineTo(this.size / 2 - this.size / 4, this.size / 2);
            }
            else if (this.way == 4)
            {
                graphics.moveTo(this.size / 2 + this.size / 4, this.size / 2);
                graphics.lineTo(this.size / 2 - this.size / 4, this.size / 2 - this.size / 4);
                graphics.lineTo(this.size / 2 - this.size / 4, this.size / 2 + this.size / 4);
                graphics.lineTo(this.size / 2 + this.size / 4, this.size / 2);
            }
            return;
        }// end function

    }
}
