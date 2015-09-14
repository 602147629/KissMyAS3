package correlation
{
    import flash.display.*;
    import player.*;

    public class CorrelationCharaFaceData extends Object
    {
        public var charaId:int;
        public var playerId:int;
        public var bBlackOut:Boolean;
        public var mc:MovieClip;
        public var fileName:String;
        public var pInfo:PlayerInformation;

        public function CorrelationCharaFaceData()
        {
            this.charaId = -1;
            this.playerId = -1;
            this.bBlackOut = false;
            this.mc = null;
            return;
        }// end function

        public function release() : void
        {
            this.pInfo = null;
            this.mc = null;
            return;
        }// end function

    }
}
