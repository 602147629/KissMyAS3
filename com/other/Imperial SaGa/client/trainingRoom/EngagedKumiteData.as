package trainingRoom
{

    public class EngagedKumiteData extends Object
    {
        public var uniqueId:int;
        public var skillId:int;
        public var kumiteType:int;
        public var kumitePlayerId:int;
        public var userId:int;
        public var userName:String;
        public var endTime:uint;
        public var noticeId:int;

        public function EngagedKumiteData(param1:Object = null)
        {
            if (param1 == null)
            {
                return;
            }
            this.uniqueId = param1.uniqueId;
            this.skillId = param1.skillId;
            this.kumiteType = param1.kumiteType;
            this.kumitePlayerId = param1.playerId;
            this.userId = param1.userId;
            this.userName = param1.userName;
            this.endTime = param1.endTime;
            this.noticeId = param1.noticeId;
            return;
        }// end function

    }
}
