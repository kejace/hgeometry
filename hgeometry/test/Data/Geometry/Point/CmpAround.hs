module Data.Geometry.Point.CmpAround where

import Data.Geometry.Point
import Data.Ext
import Control.Lens((^.))

-- | Counter clockwise ordering of the points around c. Points are ordered with
-- respect to the positive x-axis.
ccwCmpAroundByQuadrant       :: (Num r, Ord r)
                             => Point 2 r :+ qc -> Point 2 r :+ p -> Point 2 r :+ q -> Ordering
ccwCmpAroundByQuadrant c q r = case (quadrantWith c q `compare` quadrantWith c r) of
                       EQ -> case ccw (c^.core) (q^.core) (r^.core) of
                         CCW      -> LT
                         CW       -> GT
                         CoLinear -> EQ
                       x -> x -- if the quadrant differs, use the order
                              -- specified by the quadrant.
