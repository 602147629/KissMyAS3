package herovsdragon.game.background
{
    import flash.display.*;
    import herovsdragon.game.background.view.*;

    public class Background extends Object
    {
        private var body:Body;

        public function Background()
        {
            this.body = new Body();
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            param1.addChild(this.body);
            return;
        }// end function

    }
}
