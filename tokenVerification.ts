import jwt from 'npm:jsonwebtoken'
const secret = Deno.env.get("SECRET")


export function systemAdmin(req, res, next){
	try{
		const token = req.headers.authorization.split(" ")[1]
		const payload = jwt.verify(token, secret)
		if(Date().now > payload.exp){
			res.status(401).send('Sesion expirada')
		}else if(payload.type >= 1){
            res.status(401).send('Restringido')
        }
		next()
	}catch(err){
		return res.status(401).send('Token no válido');
	}
}

export function adminGeneral(req, res, next){
	try{
		const token = req.headers.authorization.split(" ")[1]
		const payload = jwt.verify(token, secret)
		if(Date().now > payload.exp){
			res.status(401).send('Sesion expirada')
		}else if(payload.type >= 2){
            res.status(401).send('Restringido')
        }
		next()
	}catch(err){
		return res.status(401).send('Token no válido');
	}
}

export function personalAdmin(req, res, next){
	try{
		const token = req.headers.authorization.split(" ")[1]
		const payload = jwt.verify(token, secret)
		if(Date().now > payload.exp){
			res.status(401).send('Sesion expirada')
		}else if(payload.type >= 3){
			res.status(401).send('Restringido')
		}else{
			next()
		}
	}catch(err){
		return res.status(401).send('Token no válido');
	}
}