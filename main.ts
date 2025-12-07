import express from "npm:express@4.18.2";
import cors from 'npm:cors'
import jwt from 'npm:jsonwebtoken'
import * as db from './dbConnection.ts'
import * as tokenVerification from './tokenVerification.ts'
import "jsr:@std/dotenv/load";

const port = Deno.env.get("PORT")
const secret = Deno.env.get("SECRET")

const app = express()
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.post('/api/login', async (req, res) => {
	const {passwordHash} = req.body
	let dbResponse
	try{
		dbResponse = await db.login(req.body)
		if(dbResponse.length == 0){
			res.status(404).send('Usuario no encontrado')
		}else if(dbResponse[0].passwordSHA256 != passwordHash){
			res.status(401).send('Contraseña Incorrecta')
		}else if(dbResponse[0].active == false){
			res.status(404).send('Este usuario se encuentra inactivo')
		}else if(dbResponse[0].type != 5 && dbResponse[0].type != 6){
			res.status(401).send('Usted no es personal administrativo')
		}else{
			const token = jwt.sign({
				id: dbResponse[0].id,
				name: dbResponse[0].name,
				type: dbResponse[0].type,
				exp: Date.now() + 600000
			}, secret)
			console.log({...dbResponse[0], jwt: token})
			res.status(200).send({...dbResponse[0], jwt: token})
		}
	}catch(err){
		console.log(err)
		res.status(500).send('error del servidor')
	}
})

//Obtener el numero de Factura a emitir
app.get('/api/getIdInvoice', tokenVerification.forAdmins, async (req, res) => {
	try{
		const dbResponse = await db.getIdInvoice()
		res.status(200).send(dbResponse)
	}catch(err){
		console.log(err)
		res.status(500).send('error del servidor')
	}
})

app.post('/api/issueInvoice', tokenVerification.forAdmins, async (req, res) => {
	const token = req.headers.authorization.split(" ")[1]
	const payload = jwt.verify(token, secret)
	try {
		const dbResponse = await db.issueInvoice(req.body)
		console.log(dbResponse)
		res.status(200).send("Factura creada exitosamente")
	} catch (err) {
		console.log(err)
		res.status(500).send('Error del servidor')
	}
})

//Modificar para verificar si un pagador ya existe
app.get('/api/getSearchedPatient/:idParam', tokenVerification.forSysAdmins, async (req, res) => {
	const idParam = req.params.idParam
	try {
		const dbResponse = await db.getSearchedPatient(idParam)
		res.status(200).send(dbResponse)
	} catch (err) {
		console.log(err)
		res.status(404).send('Paciente no encontrado')
	}
})

//Modificar para obtener citas por cedula de pagador
app.get('/api/getInvoices/:patientId/:page', tokenVerification.forAdmins, async (req, res) => {
	const patientId = req.params.patientId
	const page = Number(req.params.page)
	try{
		const dbResponse = await db.getInvoicesById(patientId, page)
		res.status(200).send(dbResponse)
	}catch(err){
		console.log(err)
		res.status(404).send('Usuario no encontrado')
	}
})

app.get('/api/getInvoices/:page', tokenVerification.forAdmins, async (req, res) => {
	const page = Number(req.params.page)
	try{
		const dbResponse = await db.getAllinvoices(page)
		res.status(200).send(dbResponse)
	}catch(err){
		console.log(err)
		res.status(404).send('Usuario no encontrado')
	}
})

//Modificar para obtener el historial competo de facturacion
app.get('/api/getAllChangeLogs/:page', tokenVerification.forSysAdmins, async (req, res) => {
	try{
		const page: number = Number(req.params.page)
		const dbResponse = await db.getLogs(page)
		res.status(200).send(dbResponse)
	}catch(err){
		console.log(err)
		res.status(500).send('error del servidor')
	}
})

app.listen(port, "0.0.0.0", () => {
	console.log(`Puerto: ${port}`)
})