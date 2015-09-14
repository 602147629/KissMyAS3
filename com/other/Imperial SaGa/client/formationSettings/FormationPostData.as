package formationSettings
{
    import flash.geom.*;
    import player.*;

    public class FormationPostData extends Object
    {
        public var uniqueId:int;
        public var tmpUniqueId:int;
        public var frontPlayer:FormationPlayerDisplay;
        public var jumpPlayer:PlayerDisplay;
        public var jumpPos:Point;
        public var jumpUniqueId:int;
        public var bJump:Boolean;

        public function FormationPostData()
        {
            this.uniqueId = Constant.EMPTY_ID;
            this.tmpUniqueId = Constant.EMPTY_ID;
            this.frontPlayer = null;
            this.jumpPlayer = null;
            this.jumpPos = new Point();
            this.jumpUniqueId = Constant.EMPTY_ID;
            this.bJump = false;
            return;
        }// end function

        public function release() : void
        {
            if (this.frontPlayer)
            {
                this.frontPlayer.release();
            }
            this.frontPlayer = null;
            if (this.jumpPlayer)
            {
                this.jumpPlayer.release();
            }
            this.jumpPlayer = null;
            return;
        }// end function

    }
}
