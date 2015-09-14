package trainingRoom
{

    public class EngagedTrainingData extends Object
    {
        public var uniqueId:int;
        public var trainingType:int;
        public var endTime:uint;
        public var noticeId:int;

        public function EngagedTrainingData(param1:Object = null)
        {
            if (param1 == null)
            {
                return;
            }
            this.uniqueId = param1.uniqueId;
            this.trainingType = param1.trainingType;
            this.endTime = param1.endTime;
            this.noticeId = param1.noticeId;
            return;
        }// end function

    }
}
