//No need to touch this code. Peeking is fine.
atom/movable
	var/coordinate/c
	proc
		pxupdate(coordinate/nc = c.Copy())
			if(!c)c = new

			//update the visual location
			var
				px = nc.x; py = nc.y
				tx = round(px/32,1)
				ty = round(py/32,1)
				atom/nloc = locate(tx, ty, nc.z)

			c.x = px; c.y = py
			loc = nloc
			pixel_x = (px- 32*tx)
			pixel_y = (py- 32*ty)

			return nloc

lineseg
	parent_type = /atom/movable
	mouse_opacity = 0
	var/line/parentLine	//reference to owner line datum

	New(coordinate/p, line, life)spawn
		if(!p)del(src) //shouldn't happen
		pxupdate(p)
		parentLine = line
		if(life>0)
			sleep(life)
			if(parentLine.segments.len==1)
				del(line)

			if(src)del(src)

line
	var
		atom
			owner
			reftarg
		coordinate
			startpoint
			endpoint

		list
			segments = list()	//a list of linesegs.
			locations = list()	//a (redundant) list of the locations of the segments.

		icon/lineicon

	Del()
		for(var/a in segments)del(a)
		..()

proc/getcoord(atom/o)return new/coordinate((o.x*32),(o.y*32),o.z)
proc/drawline(coordinate/a, coordinate/b, icon, list/a_off, list/b_off, size=4, name, life, delay, atom/owner, atom/reftarg, layerl)
	var/line/line = new

	//to be able to accept atoms as a and b.
	var/atom/a_obj
	var/atom/b_obj
	if(!istype(a,/coordinate) && istype(a,/atom))
		a_obj = a
		a = getcoord(a)
	if(!istype(b,/coordinate) && istype(b,/atom))
		b_obj = b
		b = getcoord(b)

	if(a_obj && b_obj && a_obj.z != b_obj.z)
	//The two points must be on the same z. No 3D lines allowed! \
	(though it's possible with jt_vectors, no way to visually    \
	show it yet other than probably Scaling the icon)
		return

	//a line(segment, in this case) must have a start- and end-point.
	if(!a || !b)return
	line.startpoint = a
	line.endpoint = b
	line.owner = owner
	line.reftarg = reftarg

	//if you're using pixel offsets, use the right format.
	if(a_off)if(!istype(a_off,/list) || a_off.len<2)return
	if(b_off)if(!istype(b_off,/list) || b_off.len<2)return

	//add pixel offsets to a and b
	if(a_off)
		if(a_obj){a_off[1]-=16; a_off[2]-=16}
		a.x += a_off[1]; a.y += a_off[2]
	if(b_off)
		if(b_obj){b_off[1]-=16; b_off[2]-=16}
		b.x += b_off[1]; b.y += b_off[2]

	//for safety
//	a.x = round(a.x); a.y = round(a.y)
//	b.x = round(b.x); b.y = round(b.y)

	var/bearing = a.BearingTo(b)

	//generate icon for the line if necessary
	if(isicon(icon))
		line.lineicon = new(icon)
		line.lineicon.Turn(bearing)

	//time for some action.
	var/coordinate/c = line.startpoint.Copy() //startpoint
	var/vector/section = jt_vectors.VectorFromBearing(bearing, size/2)

	var/cutoff = max(1,2*((round(a.DistanceTo(b),1)/(size))-1)) //safety variable
	while(line && cutoff>0 && (round(c.x) != b.x || round(c.y) != b.y))
		c = c.AddVector(section)

		var/lineseg/l = new(c, line, life)
		l.icon = line.lineicon
		l.layer = layerl

		if(name)
			l.name = name
			l.mouse_opacity = 1

		line.segments += l
		if(!(l.loc in line.locations))
			line.locations += l.loc

		cutoff--

	return line


var/jt_vectors/jt_vectors = new

jt_vectors
	//var/const/pi = 3.1415926535897932384626433832795

	proc/VectorFromAngle(angle=0, magnitude=1, pitch=0)
		var/vector/result = new (0,0,0)
		if(!magnitude) return result

		var/z_comp = sin(pitch)*magnitude
		var/w = sqrt(magnitude*magnitude - z_comp*z_comp)
		var/x_comp = cos(angle)*w
		var/y_comp = sin(angle)*w

		result.SetComponentX(x_comp)
		result.SetComponentY(y_comp)
		result.SetComponentZ(z_comp)

		return result


	proc/VectorFromBearing(bearing=0, magnitude=1, pitch=0)
		return VectorFromAngle(180-(bearing+90), magnitude, pitch)


coordinate
	var/x = 0.000
	var/y = 0.000
	var/z = 0.000

	New(x_coordinate = 0.000, y_coordinate = 0.000, z_coordinate = 0.000)
		..()
		src.x = x_coordinate
		src.y = y_coordinate
		src.z = z_coordinate


	proc/Copy()
		return new /coordinate(CoordinateX(), CoordinateY(), CoordinateZ())


	proc/CoordinateX() return x
	proc/CoordinateY() return y
	proc/CoordinateZ() return z
	proc/SetCoordinateX(setting) {x = setting; return x}
	proc/SetCoordinateY(setting) {y = setting; return y}
	proc/SetCoordinateZ(setting) {z = setting; return z}
	proc/ModCoordinateX(mod) {x += mod; return x}
	proc/ModCoordinateY(mod) {y += mod; return y}
	proc/ModCoordinateZ(mod) {z += mod; return z}


	proc/AddVector(vector/alt)
		return new /coordinate(
			x_coordinate = src.CoordinateX() + alt.ComponentX(),
			y_coordinate = src.CoordinateY() + alt.ComponentY(),
			z_coordinate = src.CoordinateZ() + alt.ComponentZ())


	proc/SubtractVector(vector/alt)
		return new /coordinate(
			x_coordinate = src.CoordinateX() - alt.ComponentX(),
			y_coordinate = src.CoordinateY() - alt.ComponentY(),
			z_coordinate = src.CoordinateZ() - alt.ComponentZ())


	proc/AddVectors(...)
		var/list/vectorlist = args
		if(args.len == 1 && istype(args[1],/list)) vectorlist = args[1]

		var/coordinate/dest = Copy()
		for(var/vector/alt in vectorlist)
			dest.SetCoordinateX(dest.CoordinateX() + alt.ComponentX())
			dest.SetCoordinateY(dest.CoordinateY() + alt.ComponentY())
			dest.SetCoordinateZ(dest.CoordinateZ() + alt.ComponentZ())

		return dest

	proc/SubtractVectors(...)
		var/list/vectorlist = args
		if(args.len == 1 && istype(args[1],/list)) vectorlist = args[1]

		var/coordinate/dest = Copy()
		for(var/vector/alt in vectorlist)
			dest.SetCoordinateX(dest.CoordinateX() - alt.ComponentX())
			dest.SetCoordinateY(dest.CoordinateY() - alt.ComponentY())
			dest.SetCoordinateZ(dest.CoordinateZ() - alt.ComponentZ())

		return dest


	proc/DistanceTo(coordinate/dest)
		if(istype(dest,/vector)) return DistanceTo(AddVector(dest))

		var/x_dif = dest.CoordinateX() - src.CoordinateX()
		var/y_dif = dest.CoordinateY() - src.CoordinateY()
		var/z_dif = dest.CoordinateZ() - src.CoordinateZ()
		return sqrt(x_dif*x_dif + y_dif*y_dif + z_dif*z_dif)


	proc/AngleTo(coordinate/dest)
		return AngleXYTo(dest)

	proc/BearingTo(coordinate/dest)
		return jt_vectors.AngleToBearing(AngleXYTo(dest))


	proc/AngleXYTo(coordinate/dest)
		if(istype(dest,/vector)) return AngleXYTo(AddVector(dest))
		return jt_vectors.AngleAB(\
			src.CoordinateX(),  src.CoordinateY(),
			dest.CoordinateX(), dest.CoordinateY())

	proc/AngleXZTo(coordinate/dest)
		if(istype(dest,/vector)) return AngleXZTo(AddVector(dest))
		return jt_vectors.AngleAB(\
			src.CoordinateX(),  src.CoordinateZ(),
			dest.CoordinateX(), dest.CoordinateZ())

	proc/AngleYZTo(coordinate/dest)
		if(istype(dest,/vector)) return AngleYZTo(AddVector(dest))
		return jt_vectors.AngleAB(\
			src.CoordinateY(),  src.CoordinateZ(),
			dest.CoordinateY(), dest.CoordinateZ())


	proc/PitchTo(coordinate/dest)
		if(istype(dest,/vector)) return PitchTo(AddVector(dest))
		var/opp = dest.z - src.z
		var/x_dif = dest.x - src.x
		var/y_dif = dest.y - src.y
		var/adj = sqrt(x_dif*x_dif + y_dif*y_dif)

		return jt_vectors.arctan(adj,abs(opp)) * (opp < 0 ? -1 : 1)


	proc/VectorTo(coordinate/dest)
		if(istype(dest,/vector)) return dest.Copy()

		return new /vector(\
			x_component = dest.CoordinateX() - src.CoordinateX(),
			y_component = dest.CoordinateY() - src.CoordinateY(),
			z_component = dest.CoordinateZ() - src.CoordinateZ())



vector
	var/x_comp = 0.000
	var/y_comp = 0.000
	var/z_comp = 0.000


	New(x_component = 0.000, y_component = 0.000, z_component = 0.000)
		..()
		SetComponentX(x_component)
		SetComponentY(y_component)
		SetComponentZ(z_component)


	proc/Copy()
		return new /vector(ComponentX(), ComponentY(), ComponentZ())


	proc/ComponentX() return x_comp
	proc/ComponentY() return y_comp
	proc/ComponentZ() return z_comp
	proc/SetComponentX(setting) x_comp = setting
	proc/SetComponentY(setting) y_comp = setting
	proc/SetComponentZ(setting) z_comp = setting
	proc/ModComponentX(mod) x_comp += mod
	proc/ModComponentY(mod) y_comp += mod
	proc/ModComponentZ(mod) z_comp += mod

	proc/Reverse()
		return new /vector(-ComponentX(), -ComponentY(), -ComponentZ())



	proc/Magnitude()
		var/x = ComponentX()
		var/y = ComponentY()
		var/z = ComponentZ()
		return sqrt(x*x + y*y + z*z)


	proc/Angle() return AngleXY()
	proc/Bearing() return jt_vectors.AngleToBearing(AngleXY())



	proc/AngleXY()
		if(!ComponentX() && !ComponentY()) return 90
		return jt_vectors.AngleAB(0, 0, ComponentX(), ComponentY())
	proc/AngleXZ()
		if(!ComponentX() && !ComponentZ()) return 90
		return jt_vectors.AngleAB(0, 0, ComponentX(), ComponentZ())
	proc/AngleYZ()
		if(!ComponentY() && !ComponentZ()) return 90
		return jt_vectors.AngleAB(0, 0, ComponentY(), ComponentZ())


	proc/Pitch()
		var/opp = ComponentZ()
		var/adj = sqrt(ComponentX()*ComponentX() + ComponentY()*ComponentY())
		return jt_vectors.arctan(adj,abs(opp)) * (opp < 0 ? -1 : 1)


	proc/AddVector(vector/alt)
		return new /vector(
			x_component = alt.ComponentX() + src.ComponentX(),
			y_component = alt.ComponentY() + src.ComponentY(),
			z_component = alt.ComponentZ() + src.ComponentZ())

	proc/SubtractVector(vector/alt)
		return new /vector(
			x_component = alt.ComponentX() - src.ComponentX(),
			y_component = alt.ComponentY() - src.ComponentY(),
			z_component = alt.ComponentZ() - src.ComponentZ())



	proc/AddVectors(...)
		var/list/vectorlist = args
		if(args.len == 1 && istype(args[1],/list)) vectorlist = args[1]

		var/vector/result = Copy()
		for(var/vector/alt in vectorlist)
			result.SetComponentX(result.ComponentX() + alt.ComponentX())
			result.SetComponentY(result.ComponentY() + alt.ComponentY())
			result.SetComponentZ(result.ComponentZ() + alt.ComponentZ())

		return result

	proc/SubtractVectors(...)
		var/list/vectorlist = args
		if(args.len == 1 && istype(args[1],/list)) vectorlist = args[1]

		var/vector/result = Copy()
		for(var/vector/alt in vectorlist)
			result.SetComponentX(result.ComponentX() + alt.ComponentX())
			result.SetComponentY(result.ComponentY() + alt.ComponentY())
			result.SetComponentZ(result.ComponentZ() + alt.ComponentZ())

		return result



	proc/DotProduct(vector/alt)
		return alt.ComponentX()*src.ComponentX() + \
			alt.ComponentY()*src.ComponentY() + \
			alt.ComponentZ()*src.ComponentZ()



	proc/CrossProduct(vector/alt)
		return new /vector(
			x_component = src.ComponentY()*alt.ComponentZ() - \
				src.ComponentZ()*alt.ComponentY(),
			y_component = src.ComponentZ()*alt.ComponentX() - \
				src.ComponentZ()*alt.ComponentZ(),
			z_component = src.ComponentX()*alt.ComponentY() - \
				src.ComponentY()*alt.ComponentZ())



	proc/Scale(modifier = 1.0)
		return new /vector(
			x_component = ComponentX()*modifier,
			y_component = ComponentY()*modifier,
			z_component = ComponentZ()*modifier)


	proc/ScaleX(modifier = 1.0)
		return new /vector(ComponentX()*modifier, ComponentY(), ComponentZ())
	proc/ScaleY(modifier = 1.0)
		return new /vector(ComponentX(), ComponentY()*modifier, ComponentZ())
	proc/ScaleZ(modifier = 1.0)
		return new /vector(ComponentX(), ComponentY(), ComponentZ()*modifier)


	proc/ScaleToMagnitude(setting)
		var/vector/result = new /vector(ComponentX(),ComponentY(),ComponentZ())
		var/magnitude = Magnitude()
		if(!magnitude) return new /vector(0,setting,0)
		return result.Scale(setting/magnitude)



	proc/AdjustMagnitude(mod)
		var/vector/result = new /vector(ComponentX(),ComponentY(),ComponentZ())
		var/magnitude = Magnitude()
		return result.Scale((magnitude+mod)/magnitude)

	proc/UnitVector()
		return ScaleToMagnitude(1)



	proc/DeflectXY() return new /vector(ComponentX(),ComponentY(),-ComponentZ())
	proc/DeflectXZ() return new /vector(ComponentX(),-ComponentY(),ComponentZ())
	proc/DeflectYZ() return new /vector(-ComponentX(),ComponentY(),ComponentZ())



	proc/RotateAngle(degrees)   return RotateZ(degrees)
	proc/RotateBearing(degrees) return RotateZ(-degrees)



	proc/RotateX(degrees)
		var/vector/result = new (0,0,0)
		result.SetComponentX(src.ComponentX())
		result.SetComponentY(cos(degrees)*ComponentY() - sin(degrees)*ComponentZ())
		result.SetComponentZ(sin(degrees)*ComponentY() + cos(degrees)*ComponentZ())
		return result


	proc/RotateY(degrees)
		var/vector/result = new (0,0,0)
		result.SetComponentX(cos(degrees)*ComponentX() + sin(degrees)*ComponentZ())
		result.SetComponentY(src.ComponentY())
		result.SetComponentZ(-sin(degrees)*ComponentX() + cos(degrees)*ComponentZ())
		return result


	proc/RotateZ(degrees)
		var/vector/result = new (0,0,0)
		result.SetComponentX(cos(degrees)*ComponentX() - sin(degrees)*ComponentY())
		result.SetComponentY(sin(degrees)*ComponentX() + cos(degrees)*ComponentY())
		result.SetComponentZ(src.ComponentZ())
		return result



	proc/BearingWithin(left_bound, right_bound)
		return jt_vectors.AngleABWithin(Bearing(), left_bound, right_bound)

	proc/AngleWithin(left_bound=0, right_bound=360)
		return jt_vectors.AngleABWithin(AngleXY(), left_bound, right_bound)

	proc/AngleXYWithin(left_bound=0, right_bound=360)
		return jt_vectors.AngleABWithin(AngleXY(), left_bound, right_bound)
	proc/AngleYZWithin(left_bound=0, right_bound=360)
		return jt_vectors.AngleABWithin(AngleYZ(), left_bound, right_bound)
	proc/AngleXZWithin(left_bound=0, right_bound=360)
		return jt_vectors.AngleABWithin(AngleXZ(), left_bound, right_bound)


jt_vectors
	proc/AngleAB(src_a, src_b, trg_a, trg_b)
		var/quadrant = 0
		if((trg_a - src_a) < 0) quadrant |= 1
		if((trg_b - src_b) < 0) quadrant |= 2

		var/angle_degrees = arctan(\
			abs(trg_a - src_a),
			abs(trg_b - src_b))
		if(quadrant & 1)
			if(quadrant & 2) return 180 + angle_degrees
			return 180 - angle_degrees
		if(quadrant & 2) return 360 - angle_degrees
		return angle_degrees


	proc/AngleToBearing(standard_angle)
		var/converted_angle = 360-(standard_angle-90)
		if(converted_angle < 0) converted_angle += 360
		if(converted_angle >= 360) converted_angle -= 360
		return converted_angle


	proc/BearingToAngle(bearing)
		var/converted_angle = 180-(bearing+90)
		if(converted_angle < 0) converted_angle += 360
		if(converted_angle >= 360) converted_angle -= 360
		return converted_angle

	proc/AngleABWithin(angle, left, right)
		if(left > right) {angle -= 360; left -= 360}
		return (angle >= left && angle <= right)

	proc/arctan(x,y)
		if(!x && !y) return 0
		var/a=arccos(x/sqrt(x*x+y*y))
		return (y>=0)?(a):(-a)