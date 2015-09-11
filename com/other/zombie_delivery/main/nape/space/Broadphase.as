package nape.space
{
    import flash.*;
    import zpp_nape.util.*;

    final public class Broadphase extends Object
    {

        public function Broadphase() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "Broadphase" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == this)
            {
                return "DYNAMIC_AABB_TREE";
            }
            else
            {
                if (ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == this)
                {
                    return "SWEEP_AND_PRUNE";
                }
                else
                {
                    return "";
                }
            }
        }// end function

        public static function get_DYNAMIC_AABB_TREE() : Broadphase
        {
            if (ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE;
        }// end function

        public static function get_SWEEP_AND_PRUNE() : Broadphase
        {
            if (ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.Broadphase_SWEEP_AND_PRUNE;
        }// end function

    }
}
