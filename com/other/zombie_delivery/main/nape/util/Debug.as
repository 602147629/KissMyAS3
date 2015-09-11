package nape.util
{
    import flash.*;
    import flash.display.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class Debug extends Object
    {
        public var zpp_inner:ZPP_Debug;
        public var drawShapeDetail:Boolean;
        public var drawShapeAngleIndicators:Boolean;
        public var drawSensorArbiters:Boolean;
        public var drawFluidArbiters:Boolean;
        public var drawConstraints:Boolean;
        public var drawCollisionArbiters:Boolean;
        public var drawBodyDetail:Boolean;
        public var drawBodies:Boolean;
        public var cullingEnabled:Boolean;
        public var colour:Object;

        public function Debug() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            cullingEnabled = false;
            colour = null;
            drawConstraints = false;
            drawShapeAngleIndicators = false;
            drawShapeDetail = false;
            drawBodyDetail = false;
            drawBodies = false;
            drawSensorArbiters = false;
            drawFluidArbiters = false;
            drawCollisionArbiters = false;
            zpp_inner = null;
            if (!ZPP_Debug.internal)
            {
                throw "Error: Cannot instantiate Debug derp! Use ShapeDebug, or BitmapDebug on flash10+";
            }
            drawCollisionArbiters = false;
            drawFluidArbiters = false;
            drawSensorArbiters = false;
            drawBodies = true;
            drawShapeAngleIndicators = true;
            drawBodyDetail = false;
            drawShapeDetail = false;
            drawConstraints = false;
            cullingEnabled = false;
            colour = null;
            return;
        }// end function

        public function set_transform(param1:Mat23) : Mat23
        {
            if (param1 == null)
            {
                throw "Error: Cannot set Debug::transform to null";
            }
            if (zpp_inner.xform == null)
            {
                zpp_inner.setform();
            }
            zpp_inner.xform.outer.set(param1);
            if (zpp_inner.xform == null)
            {
                zpp_inner.setform();
            }
            return zpp_inner.xform.outer;
        }// end function

        public function set_bgColour(param1:int) : int
        {
            if (zpp_inner.isbmp)
            {
                zpp_inner.d_bmp.setbg(param1);
            }
            else
            {
                zpp_inner.d_shape.setbg(param1);
            }
            return zpp_inner.bg_col;
        }// end function

        public function get_transform() : Mat23
        {
            if (zpp_inner.xform == null)
            {
                zpp_inner.setform();
            }
            return zpp_inner.xform.outer;
        }// end function

        public function get_display() : DisplayObject
        {
            var _loc_1:* = null as DisplayObject;
            if (zpp_inner.isbmp)
            {
                _loc_1 = zpp_inner.d_bmp.bitmap;
            }
            else
            {
                _loc_1 = zpp_inner.d_shape.shape;
            }
            return _loc_1;
        }// end function

        public function get_bgColour() : int
        {
            return zpp_inner.bg_col;
        }// end function

        public function flush() : void
        {
            return;
        }// end function

        public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3) : void
        {
            return;
        }// end function

        public function drawPolygon(param1, param2:int) : void
        {
            return;
        }// end function

        public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
        {
            return;
        }// end function

        public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            return;
        }// end function

        public function drawFilledPolygon(param1, param2:int) : void
        {
            return;
        }// end function

        public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            return;
        }// end function

        public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            return;
        }// end function

        public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
        {
            return;
        }// end function

        public function drawAABB(param1:AABB, param2:int) : void
        {
            return;
        }// end function

        public function draw(param1) : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public static function version() : String
        {
            return "Nape 2.0.16";
        }// end function

        public static function clearObjectPools() : void
        {
            var _loc_1:* = null as ConstraintIterator;
            var _loc_2:* = null as InteractorIterator;
            var _loc_3:* = null as BodyIterator;
            var _loc_4:* = null as CompoundIterator;
            var _loc_5:* = null as ListenerIterator;
            var _loc_6:* = null as CbTypeIterator;
            var _loc_7:* = null as ConvexResultIterator;
            var _loc_8:* = null as GeomPolyIterator;
            var _loc_9:* = null as Vec2Iterator;
            var _loc_10:* = null as RayResultIterator;
            var _loc_11:* = null as ShapeIterator;
            var _loc_12:* = null as EdgeIterator;
            var _loc_13:* = null as ContactIterator;
            var _loc_14:* = null as ArbiterIterator;
            var _loc_15:* = null as InteractionGroupIterator;
            var _loc_16:* = null as ZNPNode_ZPP_CbType;
            var _loc_17:* = null as ZNPNode_ZPP_CallbackSet;
            var _loc_18:* = null as ZPP_Material;
            var _loc_19:* = null as ZNPNode_ZPP_Shape;
            var _loc_20:* = null as ZPP_FluidProperties;
            var _loc_21:* = null as ZNPNode_ZPP_Body;
            var _loc_22:* = null as ZNPNode_ZPP_Constraint;
            var _loc_23:* = null as ZNPNode_ZPP_Compound;
            var _loc_24:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_25:* = null as ZPP_Set_ZPP_Body;
            var _loc_26:* = null as ZPP_CbSetPair;
            var _loc_27:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_28:* = null as ZNPNode_ZPP_CbSet;
            var _loc_29:* = null as ZNPNode_ZPP_Interactor;
            var _loc_30:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_31:* = null as ZPP_Callback;
            var _loc_32:* = null as ZPP_CbSet;
            var _loc_33:* = null as ZNPNode_ZPP_CbSetPair;
            var _loc_34:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_35:* = null as ZPP_GeomVert;
            var _loc_36:* = null as ZPP_Set_ZPP_CbSetPair;
            var _loc_37:* = null as ZPP_GeomVertexIterator;
            var _loc_38:* = null as ZPP_Mat23;
            var _loc_39:* = null as ZPP_CutVert;
            var _loc_40:* = null as ZPP_CutInt;
            var _loc_41:* = null as ZNPNode_ZPP_CutInt;
            var _loc_42:* = null as ZNPNode_ZPP_CutVert;
            var _loc_43:* = null as ZPP_Vec2;
            var _loc_44:* = null as ZPP_PartitionPair;
            var _loc_45:* = null as ZPP_Set_ZPP_PartitionPair;
            var _loc_46:* = null as ZNPNode_ZPP_PartitionVertex;
            var _loc_47:* = null as ZPP_PartitionVertex;
            var _loc_48:* = null as ZPP_Set_ZPP_PartitionVertex;
            var _loc_49:* = null as ZPP_PartitionedPoly;
            var _loc_50:* = null as ZPP_SimplifyV;
            var _loc_51:* = null as ZPP_SimplifyP;
            var _loc_52:* = null as ZNPNode_ZPP_PartitionedPoly;
            var _loc_53:* = null as ZNPNode_ZPP_SimplifyP;
            var _loc_54:* = null as ZPP_AABB;
            var _loc_55:* = null as ZNPNode_ZPP_GeomVert;
            var _loc_56:* = null as ZPP_ToiEvent;
            var _loc_57:* = null as ZPP_Set_ZPP_SimpleVert;
            var _loc_58:* = null as ZPP_SimpleVert;
            var _loc_59:* = null as ZPP_SimpleSeg;
            var _loc_60:* = null as ZPP_Set_ZPP_SimpleSeg;
            var _loc_61:* = null as ZPP_Set_ZPP_SimpleEvent;
            var _loc_62:* = null as ZPP_SimpleEvent;
            var _loc_63:* = null as Hashable2_Boolfalse;
            var _loc_64:* = null as ZPP_MarchSpan;
            var _loc_65:* = null as ZPP_MarchPair;
            var _loc_66:* = null as ZNPNode_ZPP_SimpleVert;
            var _loc_67:* = null as ZNPNode_ZPP_SimpleEvent;
            var _loc_68:* = null as ZNPNode_ZPP_AABBPair;
            var _loc_69:* = null as ZPP_Edge;
            var _loc_70:* = null as ZNPNode_ZPP_Vec2;
            var _loc_71:* = null as ZNPNode_ZPP_Edge;
            var _loc_72:* = null as ZPP_SweepData;
            var _loc_73:* = null as ZPP_AABBNode;
            var _loc_74:* = null as ZPP_AABBPair;
            var _loc_75:* = null as ZNPNode_ZPP_AABBNode;
            var _loc_76:* = null as ZPP_Contact;
            var _loc_77:* = null as ZNPNode_ZPP_Component;
            var _loc_78:* = null as ZPP_Island;
            var _loc_79:* = null as ZPP_Component;
            var _loc_80:* = null as ZNPNode_ZPP_InteractionGroup;
            var _loc_81:* = null as ZPP_CallbackSet;
            var _loc_82:* = null as ZPP_Set_ZPP_CbSet;
            var _loc_83:* = null as ZPP_InteractionFilter;
            var _loc_84:* = null as ZNPNode_ZPP_ColArbiter;
            var _loc_85:* = null as ZNPNode_ZPP_FluidArbiter;
            var _loc_86:* = null as ZNPNode_ZPP_SensorArbiter;
            var _loc_87:* = null as ZPP_SensorArbiter;
            var _loc_88:* = null as ZPP_FluidArbiter;
            var _loc_89:* = null as ZNPNode_ZPP_Listener;
            var _loc_90:* = null as ZNPNode_ZPP_ToiEvent;
            var _loc_91:* = null as ZPP_ColArbiter;
            var _loc_92:* = null as ZNPNode_ConvexResult;
            var _loc_93:* = null as ZNPNode_ZPP_GeomPoly;
            var _loc_94:* = null as ZNPNode_RayResult;
            var _loc_95:* = null as GeomPoly;
            var _loc_96:* = null as Vec2;
            var _loc_97:* = null as Vec3;
            while (ConstraintIterator.zpp_pool != null)
            {
                
                _loc_1 = ConstraintIterator.zpp_pool.zpp_next;
                ConstraintIterator.zpp_pool.zpp_next = null;
                ConstraintIterator.zpp_pool = _loc_1;
            }
            while (InteractorIterator.zpp_pool != null)
            {
                
                _loc_2 = InteractorIterator.zpp_pool.zpp_next;
                InteractorIterator.zpp_pool.zpp_next = null;
                InteractorIterator.zpp_pool = _loc_2;
            }
            while (BodyIterator.zpp_pool != null)
            {
                
                _loc_3 = BodyIterator.zpp_pool.zpp_next;
                BodyIterator.zpp_pool.zpp_next = null;
                BodyIterator.zpp_pool = _loc_3;
            }
            while (CompoundIterator.zpp_pool != null)
            {
                
                _loc_4 = CompoundIterator.zpp_pool.zpp_next;
                CompoundIterator.zpp_pool.zpp_next = null;
                CompoundIterator.zpp_pool = _loc_4;
            }
            while (ListenerIterator.zpp_pool != null)
            {
                
                _loc_5 = ListenerIterator.zpp_pool.zpp_next;
                ListenerIterator.zpp_pool.zpp_next = null;
                ListenerIterator.zpp_pool = _loc_5;
            }
            while (CbTypeIterator.zpp_pool != null)
            {
                
                _loc_6 = CbTypeIterator.zpp_pool.zpp_next;
                CbTypeIterator.zpp_pool.zpp_next = null;
                CbTypeIterator.zpp_pool = _loc_6;
            }
            while (ConvexResultIterator.zpp_pool != null)
            {
                
                _loc_7 = ConvexResultIterator.zpp_pool.zpp_next;
                ConvexResultIterator.zpp_pool.zpp_next = null;
                ConvexResultIterator.zpp_pool = _loc_7;
            }
            while (GeomPolyIterator.zpp_pool != null)
            {
                
                _loc_8 = GeomPolyIterator.zpp_pool.zpp_next;
                GeomPolyIterator.zpp_pool.zpp_next = null;
                GeomPolyIterator.zpp_pool = _loc_8;
            }
            while (Vec2Iterator.zpp_pool != null)
            {
                
                _loc_9 = Vec2Iterator.zpp_pool.zpp_next;
                Vec2Iterator.zpp_pool.zpp_next = null;
                Vec2Iterator.zpp_pool = _loc_9;
            }
            while (RayResultIterator.zpp_pool != null)
            {
                
                _loc_10 = RayResultIterator.zpp_pool.zpp_next;
                RayResultIterator.zpp_pool.zpp_next = null;
                RayResultIterator.zpp_pool = _loc_10;
            }
            while (ShapeIterator.zpp_pool != null)
            {
                
                _loc_11 = ShapeIterator.zpp_pool.zpp_next;
                ShapeIterator.zpp_pool.zpp_next = null;
                ShapeIterator.zpp_pool = _loc_11;
            }
            while (EdgeIterator.zpp_pool != null)
            {
                
                _loc_12 = EdgeIterator.zpp_pool.zpp_next;
                EdgeIterator.zpp_pool.zpp_next = null;
                EdgeIterator.zpp_pool = _loc_12;
            }
            while (ContactIterator.zpp_pool != null)
            {
                
                _loc_13 = ContactIterator.zpp_pool.zpp_next;
                ContactIterator.zpp_pool.zpp_next = null;
                ContactIterator.zpp_pool = _loc_13;
            }
            while (ArbiterIterator.zpp_pool != null)
            {
                
                _loc_14 = ArbiterIterator.zpp_pool.zpp_next;
                ArbiterIterator.zpp_pool.zpp_next = null;
                ArbiterIterator.zpp_pool = _loc_14;
            }
            while (InteractionGroupIterator.zpp_pool != null)
            {
                
                _loc_15 = InteractionGroupIterator.zpp_pool.zpp_next;
                InteractionGroupIterator.zpp_pool.zpp_next = null;
                InteractionGroupIterator.zpp_pool = _loc_15;
            }
            while (ZNPNode_ZPP_CbType.zpp_pool != null)
            {
                
                _loc_16 = ZNPNode_ZPP_CbType.zpp_pool.next;
                ZNPNode_ZPP_CbType.zpp_pool.next = null;
                ZNPNode_ZPP_CbType.zpp_pool = _loc_16;
            }
            while (ZNPNode_ZPP_CallbackSet.zpp_pool != null)
            {
                
                _loc_17 = ZNPNode_ZPP_CallbackSet.zpp_pool.next;
                ZNPNode_ZPP_CallbackSet.zpp_pool.next = null;
                ZNPNode_ZPP_CallbackSet.zpp_pool = _loc_17;
            }
            while (ZPP_Material.zpp_pool != null)
            {
                
                _loc_18 = ZPP_Material.zpp_pool.next;
                ZPP_Material.zpp_pool.next = null;
                ZPP_Material.zpp_pool = _loc_18;
            }
            while (ZNPNode_ZPP_Shape.zpp_pool != null)
            {
                
                _loc_19 = ZNPNode_ZPP_Shape.zpp_pool.next;
                ZNPNode_ZPP_Shape.zpp_pool.next = null;
                ZNPNode_ZPP_Shape.zpp_pool = _loc_19;
            }
            while (ZPP_FluidProperties.zpp_pool != null)
            {
                
                _loc_20 = ZPP_FluidProperties.zpp_pool.next;
                ZPP_FluidProperties.zpp_pool.next = null;
                ZPP_FluidProperties.zpp_pool = _loc_20;
            }
            while (ZNPNode_ZPP_Body.zpp_pool != null)
            {
                
                _loc_21 = ZNPNode_ZPP_Body.zpp_pool.next;
                ZNPNode_ZPP_Body.zpp_pool.next = null;
                ZNPNode_ZPP_Body.zpp_pool = _loc_21;
            }
            while (ZNPNode_ZPP_Constraint.zpp_pool != null)
            {
                
                _loc_22 = ZNPNode_ZPP_Constraint.zpp_pool.next;
                ZNPNode_ZPP_Constraint.zpp_pool.next = null;
                ZNPNode_ZPP_Constraint.zpp_pool = _loc_22;
            }
            while (ZNPNode_ZPP_Compound.zpp_pool != null)
            {
                
                _loc_23 = ZNPNode_ZPP_Compound.zpp_pool.next;
                ZNPNode_ZPP_Compound.zpp_pool.next = null;
                ZNPNode_ZPP_Compound.zpp_pool = _loc_23;
            }
            while (ZNPNode_ZPP_Arbiter.zpp_pool != null)
            {
                
                _loc_24 = ZNPNode_ZPP_Arbiter.zpp_pool.next;
                ZNPNode_ZPP_Arbiter.zpp_pool.next = null;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_24;
            }
            while (ZPP_Set_ZPP_Body.zpp_pool != null)
            {
                
                _loc_25 = ZPP_Set_ZPP_Body.zpp_pool.next;
                ZPP_Set_ZPP_Body.zpp_pool.next = null;
                ZPP_Set_ZPP_Body.zpp_pool = _loc_25;
            }
            while (ZPP_CbSetPair.zpp_pool != null)
            {
                
                _loc_26 = ZPP_CbSetPair.zpp_pool.next;
                ZPP_CbSetPair.zpp_pool.next = null;
                ZPP_CbSetPair.zpp_pool = _loc_26;
            }
            while (ZNPNode_ZPP_InteractionListener.zpp_pool != null)
            {
                
                _loc_27 = ZNPNode_ZPP_InteractionListener.zpp_pool.next;
                ZNPNode_ZPP_InteractionListener.zpp_pool.next = null;
                ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_27;
            }
            while (ZNPNode_ZPP_CbSet.zpp_pool != null)
            {
                
                _loc_28 = ZNPNode_ZPP_CbSet.zpp_pool.next;
                ZNPNode_ZPP_CbSet.zpp_pool.next = null;
                ZNPNode_ZPP_CbSet.zpp_pool = _loc_28;
            }
            while (ZNPNode_ZPP_Interactor.zpp_pool != null)
            {
                
                _loc_29 = ZNPNode_ZPP_Interactor.zpp_pool.next;
                ZNPNode_ZPP_Interactor.zpp_pool.next = null;
                ZNPNode_ZPP_Interactor.zpp_pool = _loc_29;
            }
            while (ZNPNode_ZPP_BodyListener.zpp_pool != null)
            {
                
                _loc_30 = ZNPNode_ZPP_BodyListener.zpp_pool.next;
                ZNPNode_ZPP_BodyListener.zpp_pool.next = null;
                ZNPNode_ZPP_BodyListener.zpp_pool = _loc_30;
            }
            while (ZPP_Callback.zpp_pool != null)
            {
                
                _loc_31 = ZPP_Callback.zpp_pool.next;
                ZPP_Callback.zpp_pool.next = null;
                ZPP_Callback.zpp_pool = _loc_31;
            }
            while (ZPP_CbSet.zpp_pool != null)
            {
                
                _loc_32 = ZPP_CbSet.zpp_pool.next;
                ZPP_CbSet.zpp_pool.next = null;
                ZPP_CbSet.zpp_pool = _loc_32;
            }
            while (ZNPNode_ZPP_CbSetPair.zpp_pool != null)
            {
                
                _loc_33 = ZNPNode_ZPP_CbSetPair.zpp_pool.next;
                ZNPNode_ZPP_CbSetPair.zpp_pool.next = null;
                ZNPNode_ZPP_CbSetPair.zpp_pool = _loc_33;
            }
            while (ZNPNode_ZPP_ConstraintListener.zpp_pool != null)
            {
                
                _loc_34 = ZNPNode_ZPP_ConstraintListener.zpp_pool.next;
                ZNPNode_ZPP_ConstraintListener.zpp_pool.next = null;
                ZNPNode_ZPP_ConstraintListener.zpp_pool = _loc_34;
            }
            while (ZPP_GeomVert.zpp_pool != null)
            {
                
                _loc_35 = ZPP_GeomVert.zpp_pool.next;
                ZPP_GeomVert.zpp_pool.next = null;
                ZPP_GeomVert.zpp_pool = _loc_35;
            }
            while (ZPP_Set_ZPP_CbSetPair.zpp_pool != null)
            {
                
                _loc_36 = ZPP_Set_ZPP_CbSetPair.zpp_pool.next;
                ZPP_Set_ZPP_CbSetPair.zpp_pool.next = null;
                ZPP_Set_ZPP_CbSetPair.zpp_pool = _loc_36;
            }
            while (ZPP_GeomVertexIterator.zpp_pool != null)
            {
                
                _loc_37 = ZPP_GeomVertexIterator.zpp_pool.next;
                ZPP_GeomVertexIterator.zpp_pool.next = null;
                ZPP_GeomVertexIterator.zpp_pool = _loc_37;
            }
            while (ZPP_Mat23.zpp_pool != null)
            {
                
                _loc_38 = ZPP_Mat23.zpp_pool.next;
                ZPP_Mat23.zpp_pool.next = null;
                ZPP_Mat23.zpp_pool = _loc_38;
            }
            while (ZPP_CutVert.zpp_pool != null)
            {
                
                _loc_39 = ZPP_CutVert.zpp_pool.next;
                ZPP_CutVert.zpp_pool.next = null;
                ZPP_CutVert.zpp_pool = _loc_39;
            }
            while (ZPP_CutInt.zpp_pool != null)
            {
                
                _loc_40 = ZPP_CutInt.zpp_pool.next;
                ZPP_CutInt.zpp_pool.next = null;
                ZPP_CutInt.zpp_pool = _loc_40;
            }
            while (ZNPNode_ZPP_CutInt.zpp_pool != null)
            {
                
                _loc_41 = ZNPNode_ZPP_CutInt.zpp_pool.next;
                ZNPNode_ZPP_CutInt.zpp_pool.next = null;
                ZNPNode_ZPP_CutInt.zpp_pool = _loc_41;
            }
            while (ZNPNode_ZPP_CutVert.zpp_pool != null)
            {
                
                _loc_42 = ZNPNode_ZPP_CutVert.zpp_pool.next;
                ZNPNode_ZPP_CutVert.zpp_pool.next = null;
                ZNPNode_ZPP_CutVert.zpp_pool = _loc_42;
            }
            while (ZPP_Vec2.zpp_pool != null)
            {
                
                _loc_43 = ZPP_Vec2.zpp_pool.next;
                ZPP_Vec2.zpp_pool.next = null;
                ZPP_Vec2.zpp_pool = _loc_43;
            }
            while (ZPP_PartitionPair.zpp_pool != null)
            {
                
                _loc_44 = ZPP_PartitionPair.zpp_pool.next;
                ZPP_PartitionPair.zpp_pool.next = null;
                ZPP_PartitionPair.zpp_pool = _loc_44;
            }
            while (ZPP_Set_ZPP_PartitionPair.zpp_pool != null)
            {
                
                _loc_45 = ZPP_Set_ZPP_PartitionPair.zpp_pool.next;
                ZPP_Set_ZPP_PartitionPair.zpp_pool.next = null;
                ZPP_Set_ZPP_PartitionPair.zpp_pool = _loc_45;
            }
            while (ZNPNode_ZPP_PartitionVertex.zpp_pool != null)
            {
                
                _loc_46 = ZNPNode_ZPP_PartitionVertex.zpp_pool.next;
                ZNPNode_ZPP_PartitionVertex.zpp_pool.next = null;
                ZNPNode_ZPP_PartitionVertex.zpp_pool = _loc_46;
            }
            while (ZPP_PartitionVertex.zpp_pool != null)
            {
                
                _loc_47 = ZPP_PartitionVertex.zpp_pool.next;
                ZPP_PartitionVertex.zpp_pool.next = null;
                ZPP_PartitionVertex.zpp_pool = _loc_47;
            }
            while (ZPP_Set_ZPP_PartitionVertex.zpp_pool != null)
            {
                
                _loc_48 = ZPP_Set_ZPP_PartitionVertex.zpp_pool.next;
                ZPP_Set_ZPP_PartitionVertex.zpp_pool.next = null;
                ZPP_Set_ZPP_PartitionVertex.zpp_pool = _loc_48;
            }
            while (ZPP_PartitionedPoly.zpp_pool != null)
            {
                
                _loc_49 = ZPP_PartitionedPoly.zpp_pool.next;
                ZPP_PartitionedPoly.zpp_pool.next = null;
                ZPP_PartitionedPoly.zpp_pool = _loc_49;
            }
            while (ZPP_SimplifyV.zpp_pool != null)
            {
                
                _loc_50 = ZPP_SimplifyV.zpp_pool.next;
                ZPP_SimplifyV.zpp_pool.next = null;
                ZPP_SimplifyV.zpp_pool = _loc_50;
            }
            while (ZPP_SimplifyP.zpp_pool != null)
            {
                
                _loc_51 = ZPP_SimplifyP.zpp_pool.next;
                ZPP_SimplifyP.zpp_pool.next = null;
                ZPP_SimplifyP.zpp_pool = _loc_51;
            }
            while (ZNPNode_ZPP_PartitionedPoly.zpp_pool != null)
            {
                
                _loc_52 = ZNPNode_ZPP_PartitionedPoly.zpp_pool.next;
                ZNPNode_ZPP_PartitionedPoly.zpp_pool.next = null;
                ZNPNode_ZPP_PartitionedPoly.zpp_pool = _loc_52;
            }
            while (ZNPNode_ZPP_SimplifyP.zpp_pool != null)
            {
                
                _loc_53 = ZNPNode_ZPP_SimplifyP.zpp_pool.next;
                ZNPNode_ZPP_SimplifyP.zpp_pool.next = null;
                ZNPNode_ZPP_SimplifyP.zpp_pool = _loc_53;
            }
            while (ZPP_AABB.zpp_pool != null)
            {
                
                _loc_54 = ZPP_AABB.zpp_pool.next;
                ZPP_AABB.zpp_pool.next = null;
                ZPP_AABB.zpp_pool = _loc_54;
            }
            while (ZNPNode_ZPP_GeomVert.zpp_pool != null)
            {
                
                _loc_55 = ZNPNode_ZPP_GeomVert.zpp_pool.next;
                ZNPNode_ZPP_GeomVert.zpp_pool.next = null;
                ZNPNode_ZPP_GeomVert.zpp_pool = _loc_55;
            }
            while (ZPP_ToiEvent.zpp_pool != null)
            {
                
                _loc_56 = ZPP_ToiEvent.zpp_pool.next;
                ZPP_ToiEvent.zpp_pool.next = null;
                ZPP_ToiEvent.zpp_pool = _loc_56;
            }
            while (ZPP_Set_ZPP_SimpleVert.zpp_pool != null)
            {
                
                _loc_57 = ZPP_Set_ZPP_SimpleVert.zpp_pool.next;
                ZPP_Set_ZPP_SimpleVert.zpp_pool.next = null;
                ZPP_Set_ZPP_SimpleVert.zpp_pool = _loc_57;
            }
            while (ZPP_SimpleVert.zpp_pool != null)
            {
                
                _loc_58 = ZPP_SimpleVert.zpp_pool.next;
                ZPP_SimpleVert.zpp_pool.next = null;
                ZPP_SimpleVert.zpp_pool = _loc_58;
            }
            while (ZPP_SimpleSeg.zpp_pool != null)
            {
                
                _loc_59 = ZPP_SimpleSeg.zpp_pool.next;
                ZPP_SimpleSeg.zpp_pool.next = null;
                ZPP_SimpleSeg.zpp_pool = _loc_59;
            }
            while (ZPP_Set_ZPP_SimpleSeg.zpp_pool != null)
            {
                
                _loc_60 = ZPP_Set_ZPP_SimpleSeg.zpp_pool.next;
                ZPP_Set_ZPP_SimpleSeg.zpp_pool.next = null;
                ZPP_Set_ZPP_SimpleSeg.zpp_pool = _loc_60;
            }
            while (ZPP_Set_ZPP_SimpleEvent.zpp_pool != null)
            {
                
                _loc_61 = ZPP_Set_ZPP_SimpleEvent.zpp_pool.next;
                ZPP_Set_ZPP_SimpleEvent.zpp_pool.next = null;
                ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc_61;
            }
            while (ZPP_SimpleEvent.zpp_pool != null)
            {
                
                _loc_62 = ZPP_SimpleEvent.zpp_pool.next;
                ZPP_SimpleEvent.zpp_pool.next = null;
                ZPP_SimpleEvent.zpp_pool = _loc_62;
            }
            while (Hashable2_Boolfalse.zpp_pool != null)
            {
                
                _loc_63 = Hashable2_Boolfalse.zpp_pool.next;
                Hashable2_Boolfalse.zpp_pool.next = null;
                Hashable2_Boolfalse.zpp_pool = _loc_63;
            }
            while (ZPP_MarchSpan.zpp_pool != null)
            {
                
                _loc_64 = ZPP_MarchSpan.zpp_pool.next;
                ZPP_MarchSpan.zpp_pool.next = null;
                ZPP_MarchSpan.zpp_pool = _loc_64;
            }
            while (ZPP_MarchPair.zpp_pool != null)
            {
                
                _loc_65 = ZPP_MarchPair.zpp_pool.next;
                ZPP_MarchPair.zpp_pool.next = null;
                ZPP_MarchPair.zpp_pool = _loc_65;
            }
            while (ZNPNode_ZPP_SimpleVert.zpp_pool != null)
            {
                
                _loc_66 = ZNPNode_ZPP_SimpleVert.zpp_pool.next;
                ZNPNode_ZPP_SimpleVert.zpp_pool.next = null;
                ZNPNode_ZPP_SimpleVert.zpp_pool = _loc_66;
            }
            while (ZNPNode_ZPP_SimpleEvent.zpp_pool != null)
            {
                
                _loc_67 = ZNPNode_ZPP_SimpleEvent.zpp_pool.next;
                ZNPNode_ZPP_SimpleEvent.zpp_pool.next = null;
                ZNPNode_ZPP_SimpleEvent.zpp_pool = _loc_67;
            }
            while (ZNPNode_ZPP_AABBPair.zpp_pool != null)
            {
                
                _loc_68 = ZNPNode_ZPP_AABBPair.zpp_pool.next;
                ZNPNode_ZPP_AABBPair.zpp_pool.next = null;
                ZNPNode_ZPP_AABBPair.zpp_pool = _loc_68;
            }
            while (ZPP_Edge.zpp_pool != null)
            {
                
                _loc_69 = ZPP_Edge.zpp_pool.next;
                ZPP_Edge.zpp_pool.next = null;
                ZPP_Edge.zpp_pool = _loc_69;
            }
            while (ZNPNode_ZPP_Vec2.zpp_pool != null)
            {
                
                _loc_70 = ZNPNode_ZPP_Vec2.zpp_pool.next;
                ZNPNode_ZPP_Vec2.zpp_pool.next = null;
                ZNPNode_ZPP_Vec2.zpp_pool = _loc_70;
            }
            while (ZNPNode_ZPP_Edge.zpp_pool != null)
            {
                
                _loc_71 = ZNPNode_ZPP_Edge.zpp_pool.next;
                ZNPNode_ZPP_Edge.zpp_pool.next = null;
                ZNPNode_ZPP_Edge.zpp_pool = _loc_71;
            }
            while (ZPP_SweepData.zpp_pool != null)
            {
                
                _loc_72 = ZPP_SweepData.zpp_pool.next;
                ZPP_SweepData.zpp_pool.next = null;
                ZPP_SweepData.zpp_pool = _loc_72;
            }
            while (ZPP_AABBNode.zpp_pool != null)
            {
                
                _loc_73 = ZPP_AABBNode.zpp_pool.next;
                ZPP_AABBNode.zpp_pool.next = null;
                ZPP_AABBNode.zpp_pool = _loc_73;
            }
            while (ZPP_AABBPair.zpp_pool != null)
            {
                
                _loc_74 = ZPP_AABBPair.zpp_pool.next;
                ZPP_AABBPair.zpp_pool.next = null;
                ZPP_AABBPair.zpp_pool = _loc_74;
            }
            while (ZNPNode_ZPP_AABBNode.zpp_pool != null)
            {
                
                _loc_75 = ZNPNode_ZPP_AABBNode.zpp_pool.next;
                ZNPNode_ZPP_AABBNode.zpp_pool.next = null;
                ZNPNode_ZPP_AABBNode.zpp_pool = _loc_75;
            }
            while (ZPP_Contact.zpp_pool != null)
            {
                
                _loc_76 = ZPP_Contact.zpp_pool.next;
                ZPP_Contact.zpp_pool.next = null;
                ZPP_Contact.zpp_pool = _loc_76;
            }
            while (ZNPNode_ZPP_Component.zpp_pool != null)
            {
                
                _loc_77 = ZNPNode_ZPP_Component.zpp_pool.next;
                ZNPNode_ZPP_Component.zpp_pool.next = null;
                ZNPNode_ZPP_Component.zpp_pool = _loc_77;
            }
            while (ZPP_Island.zpp_pool != null)
            {
                
                _loc_78 = ZPP_Island.zpp_pool.next;
                ZPP_Island.zpp_pool.next = null;
                ZPP_Island.zpp_pool = _loc_78;
            }
            while (ZPP_Component.zpp_pool != null)
            {
                
                _loc_79 = ZPP_Component.zpp_pool.next;
                ZPP_Component.zpp_pool.next = null;
                ZPP_Component.zpp_pool = _loc_79;
            }
            while (ZNPNode_ZPP_InteractionGroup.zpp_pool != null)
            {
                
                _loc_80 = ZNPNode_ZPP_InteractionGroup.zpp_pool.next;
                ZNPNode_ZPP_InteractionGroup.zpp_pool.next = null;
                ZNPNode_ZPP_InteractionGroup.zpp_pool = _loc_80;
            }
            while (ZPP_CallbackSet.zpp_pool != null)
            {
                
                _loc_81 = ZPP_CallbackSet.zpp_pool.next;
                ZPP_CallbackSet.zpp_pool.next = null;
                ZPP_CallbackSet.zpp_pool = _loc_81;
            }
            while (ZPP_Set_ZPP_CbSet.zpp_pool != null)
            {
                
                _loc_82 = ZPP_Set_ZPP_CbSet.zpp_pool.next;
                ZPP_Set_ZPP_CbSet.zpp_pool.next = null;
                ZPP_Set_ZPP_CbSet.zpp_pool = _loc_82;
            }
            while (ZPP_InteractionFilter.zpp_pool != null)
            {
                
                _loc_83 = ZPP_InteractionFilter.zpp_pool.next;
                ZPP_InteractionFilter.zpp_pool.next = null;
                ZPP_InteractionFilter.zpp_pool = _loc_83;
            }
            while (ZNPNode_ZPP_ColArbiter.zpp_pool != null)
            {
                
                _loc_84 = ZNPNode_ZPP_ColArbiter.zpp_pool.next;
                ZNPNode_ZPP_ColArbiter.zpp_pool.next = null;
                ZNPNode_ZPP_ColArbiter.zpp_pool = _loc_84;
            }
            while (ZNPNode_ZPP_FluidArbiter.zpp_pool != null)
            {
                
                _loc_85 = ZNPNode_ZPP_FluidArbiter.zpp_pool.next;
                ZNPNode_ZPP_FluidArbiter.zpp_pool.next = null;
                ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc_85;
            }
            while (ZNPNode_ZPP_SensorArbiter.zpp_pool != null)
            {
                
                _loc_86 = ZNPNode_ZPP_SensorArbiter.zpp_pool.next;
                ZNPNode_ZPP_SensorArbiter.zpp_pool.next = null;
                ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc_86;
            }
            while (ZPP_SensorArbiter.zpp_pool != null)
            {
                
                _loc_87 = ZPP_SensorArbiter.zpp_pool.next;
                ZPP_SensorArbiter.zpp_pool.next = null;
                ZPP_SensorArbiter.zpp_pool = _loc_87;
            }
            while (ZPP_FluidArbiter.zpp_pool != null)
            {
                
                _loc_88 = ZPP_FluidArbiter.zpp_pool.next;
                ZPP_FluidArbiter.zpp_pool.next = null;
                ZPP_FluidArbiter.zpp_pool = _loc_88;
            }
            while (ZNPNode_ZPP_Listener.zpp_pool != null)
            {
                
                _loc_89 = ZNPNode_ZPP_Listener.zpp_pool.next;
                ZNPNode_ZPP_Listener.zpp_pool.next = null;
                ZNPNode_ZPP_Listener.zpp_pool = _loc_89;
            }
            while (ZNPNode_ZPP_ToiEvent.zpp_pool != null)
            {
                
                _loc_90 = ZNPNode_ZPP_ToiEvent.zpp_pool.next;
                ZNPNode_ZPP_ToiEvent.zpp_pool.next = null;
                ZNPNode_ZPP_ToiEvent.zpp_pool = _loc_90;
            }
            while (ZPP_ColArbiter.zpp_pool != null)
            {
                
                _loc_91 = ZPP_ColArbiter.zpp_pool.next;
                ZPP_ColArbiter.zpp_pool.next = null;
                ZPP_ColArbiter.zpp_pool = _loc_91;
            }
            while (ZNPNode_ConvexResult.zpp_pool != null)
            {
                
                _loc_92 = ZNPNode_ConvexResult.zpp_pool.next;
                ZNPNode_ConvexResult.zpp_pool.next = null;
                ZNPNode_ConvexResult.zpp_pool = _loc_92;
            }
            while (ZNPNode_ZPP_GeomPoly.zpp_pool != null)
            {
                
                _loc_93 = ZNPNode_ZPP_GeomPoly.zpp_pool.next;
                ZNPNode_ZPP_GeomPoly.zpp_pool.next = null;
                ZNPNode_ZPP_GeomPoly.zpp_pool = _loc_93;
            }
            while (ZNPNode_RayResult.zpp_pool != null)
            {
                
                _loc_94 = ZNPNode_RayResult.zpp_pool.next;
                ZNPNode_RayResult.zpp_pool.next = null;
                ZNPNode_RayResult.zpp_pool = _loc_94;
            }
            while (ZPP_PubPool.poolGeomPoly != null)
            {
                
                _loc_95 = ZPP_PubPool.poolGeomPoly.zpp_pool;
                ZPP_PubPool.poolGeomPoly.zpp_pool = null;
                ZPP_PubPool.poolGeomPoly = _loc_95;
            }
            while (ZPP_PubPool.poolVec2 != null)
            {
                
                _loc_96 = ZPP_PubPool.poolVec2.zpp_pool;
                ZPP_PubPool.poolVec2.zpp_pool = null;
                ZPP_PubPool.poolVec2 = _loc_96;
            }
            while (ZPP_PubPool.poolVec3 != null)
            {
                
                _loc_97 = ZPP_PubPool.poolVec3.zpp_pool;
                ZPP_PubPool.poolVec3.zpp_pool = null;
                ZPP_PubPool.poolVec3 = _loc_97;
            }
            return;
        }// end function

        public static function createGraphic(param1:Body) : Shape
        {
            var _loc_10:* = null as ShapeList;
            var _loc_11:* = null as Shape;
            var _loc_12:* = 0;
            var _loc_13:* = null as Circle;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = null as ZPP_Vec2;
            var _loc_16:* = null as Polygon;
            var _loc_17:* = 0;
            var _loc_18:* = null as Vec2List;
            var _loc_19:* = 0;
            if (param1 == null)
            {
                throw "Error: Cannot create debug graphic for null Body";
            }
            var _loc_2:* = new Shape();
            var _loc_3:* = _loc_2.graphics;
            var _loc_4:* = 16777215 * Math.exp((-param1.zpp_inner_i.id) / 1500);
            var _loc_5:* = ((_loc_4 & 16711680) >> 16) * 0.7;
            var _loc_6:* = ((_loc_4 & 65280) >> 8) * 0.7;
            var _loc_7:* = (_loc_4 & 255) * 0.7;
            var _loc_8:* = _loc_5 << 16 | _loc_6 << 8 | _loc_7;
            _loc_3.lineStyle(0.1, _loc_8, 1);
            _loc_10 = param1.zpp_inner.wrap_shapes;
            _loc_10.zpp_inner.valmod();
            var _loc_9:* = ShapeIterator.get(_loc_10);
            do
            {
                
                _loc_9.zpp_critical = false;
                _loc_12 = _loc_9.zpp_i;
                (_loc_9.zpp_i + 1);
                _loc_11 = _loc_9.zpp_inner.at(_loc_12);
                if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_13 = _loc_11.zpp_inner.circle.outer_zn;
                    }
                    else
                    {
                        _loc_13 = null;
                    }
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    _loc_3.drawCircle(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y, _loc_13.zpp_inner_zn.radius);
                }
                else
                {
                    if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_16 = _loc_11.zpp_inner.polygon.outer_zn;
                    }
                    else
                    {
                        _loc_16 = null;
                    }
                    if (_loc_11.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_11.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_11.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_11.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    if (_loc_11.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_11.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_11.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_11.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    _loc_3.moveTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                    _loc_12 = 0;
                    if (_loc_16.zpp_inner_zn.wrap_gverts == null)
                    {
                        _loc_16.zpp_inner_zn.getgverts();
                    }
                    _loc_18 = _loc_16.zpp_inner_zn.wrap_gverts;
                    _loc_17 = _loc_18.zpp_gl();
                    while (_loc_12 < _loc_17)
                    {
                        
                        _loc_12++;
                        _loc_19 = _loc_12;
                        if (_loc_16.zpp_inner_zn.wrap_lverts == null)
                        {
                            _loc_16.zpp_inner_zn.getlverts();
                        }
                        _loc_14 = _loc_16.zpp_inner_zn.wrap_lverts.at(_loc_19);
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_15 = _loc_14.zpp_inner;
                        if (_loc_15._validate != null)
                        {
                            _loc_15._validate();
                        }
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_15 = _loc_14.zpp_inner;
                        if (_loc_15._validate != null)
                        {
                            _loc_15._validate();
                        }
                        _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                    }
                    if (_loc_16.zpp_inner_zn.wrap_lverts == null)
                    {
                        _loc_16.zpp_inner_zn.getlverts();
                    }
                    _loc_14 = _loc_16.zpp_inner_zn.wrap_lverts.at(0);
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    _loc_3.lineTo(_loc_14.zpp_inner.x, _loc_14.zpp_inner.y);
                }
                if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    if (_loc_11.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_13 = _loc_11.zpp_inner.circle.outer_zn;
                    }
                    else
                    {
                        _loc_13 = null;
                    }
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    _loc_3.moveTo(_loc_14.zpp_inner.x + _loc_13.zpp_inner_zn.radius * 0.3, _loc_14.zpp_inner.y);
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    if (_loc_13.zpp_inner.wrap_localCOM == null)
                    {
                        if (_loc_13.zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_13.zpp_inner.circle.setupLocalCOM();
                        }
                        else
                        {
                            _loc_13.zpp_inner.polygon.setupLocalCOM();
                        }
                    }
                    _loc_14 = _loc_13.zpp_inner.wrap_localCOM;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_15 = _loc_14.zpp_inner;
                    if (_loc_15._validate != null)
                    {
                        _loc_15._validate();
                    }
                    _loc_3.lineTo(_loc_14.zpp_inner.x + _loc_13.zpp_inner_zn.radius, _loc_14.zpp_inner.y);
                }
                _loc_9.zpp_inner.zpp_inner.valmod();
                _loc_10 = _loc_9.zpp_inner;
                _loc_10.zpp_inner.valmod();
                if (_loc_10.zpp_inner.zip_length)
                {
                    _loc_10.zpp_inner.zip_length = false;
                    _loc_10.zpp_inner.user_length = _loc_10.zpp_inner.inner.length;
                }
                _loc_12 = _loc_10.zpp_inner.user_length;
                _loc_9.zpp_critical = true;
            }while (_loc_9.zpp_i < _loc_12 ? (true) : (_loc_9.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc_9, _loc_9.zpp_inner = null, false))
            return _loc_2;
        }// end function

    }
}
