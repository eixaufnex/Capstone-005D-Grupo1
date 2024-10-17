import express from 'express'
import usuarioRoutes from './routes/usuario.routes.js' //------------------------usuario
import gr_muscularRoutes from './routes/gr_muscular.routes.js' //----------------grupo muscular
import list_ejercicioRoutes from './routes/list_ejercicio.routes.js' //----------lista ejercicio
import detalle_ejercicioRoutes from './routes/detalle_ejercicio.routes.js' //----detalle ejercicio
import rutina_detalladaRoutes from './routes/rutina_detallada.routes.js' //------rutina detallada
import progresoRoutes from './routes/progreso.routes.js' //----------------------progreso
import rutinaRoutes from './routes/rutina.routes.js' //--------------------------rutina
import perfilRoutes from './routes/perfil.routes.js' //--------------------------perifl
import feedbackRoutes from './routes/feedback.routes.js' //----------------------feedback
import logroRoutes from './routes/logro.routes.js' //----------------------------logro
import objetivoRoutes from './routes/objetivo.routes.js' //----------------------objetivo
import notificacionRoutes from './routes/notificacion.routes.js' //--------------notificacion

const app = express();
app.use(express.json());

app.use(usuarioRoutes); //---------------usuario
app.use(gr_muscularRoutes); //-----------grupo muscular
app.use(perfilRoutes); //----------------perfil
app.use(feedbackRoutes); //--------------feedback
app.use(logroRoutes); //-----------------logro
app.use(objetivoRoutes); //--------------objetivo
app.use(notificacionRoutes); //----------notificacion
app.use(list_ejercicioRoutes); //--------lista ejercicio
app.use(detalle_ejercicioRoutes); //-----detalle ejercicio
app.use(rutina_detalladaRoutes); //------rutina detallada
app.use(progresoRoutes); //--------------progreso
app.use(rutinaRoutes); //----------------rutina


export default app