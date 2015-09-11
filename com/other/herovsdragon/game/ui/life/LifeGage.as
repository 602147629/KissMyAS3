package herovsdragon.game.ui.life
{
    import flash.display.*;
    import herovsdragon.game.ui.life.view.*;

    public class LifeGage extends Object
    {
        private var body:Body;

        public function LifeGage(param1:int, param2:int)
        {
            this.body = new Body();
            this.body.x = param1;
            this.body.y = param2;
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            param1.addChild(this.body);
            return;
        }// end function

        public function get _body() : Body
        {
            return this.body;
        }// end function

    }
}
