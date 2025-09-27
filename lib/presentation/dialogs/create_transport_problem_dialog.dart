import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateTransportProblemDialog {
  static showTransportProblemDialog(BuildContext context,){
    showDialog(
      context: context, 
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
        child: _CreateDialogView(),
      ),
    );
  }
}

class _CreateDialogView extends StatefulWidget {
  const _CreateDialogView();

  @override
  State<_CreateDialogView> createState() => _CreateDialogViewState();
}

class _CreateDialogViewState extends State<_CreateDialogView> {
    final _formKey = GlobalKey<FormState>();
    final _nameTextController = TextEditingController();
    final _sourcesTextController = TextEditingController();
    final _destinationsTextController = TextEditingController();

    @override
    void dispose() {
      super.dispose();
      _nameTextController.dispose();
      _sourcesTextController.dispose();
      _destinationsTextController.dispose();
    }
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final textFormDecoration = InputDecoration(
      errorStyle: TextStyle(fontSize: 0,height: 0),
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      )
    );

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15,vertical: 10),
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: 340,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Crear Problema", style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w700,fontSize: 20))
              ),
              SizedBox(height: 20,),
              Text("Nombre",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600),),
              SizedBox(
                height: 30,
                child: TextFormField(
                  validator: (value) {
                    if(value?.isEmpty??false)return "El campo no puede estar vacío";
                    return null;
                  },
                  controller: _nameTextController,
                  cursorColor: Color(0xFFB71C1C),
                  decoration: textFormDecoration,
                ),
              ),
              SizedBox(height: 20,),
              Text("Numero de fuentes",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600),),
              SizedBox(
                height: 30,
                child: TextFormField(
                  controller: _sourcesTextController,
                  cursorColor: Color(0xFFB71C1C),
                  decoration: textFormDecoration,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value?.isEmpty??false)return "El campo no puede estar vacío";
                    if(int.tryParse(value!)==null)return "El valor no tiene el formato correcto";
                    if(int.tryParse(value)!<2)return "El valor tiene que ser mayor a 2";
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text("Numero de destinos",style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600),),
              SizedBox(
                height: 30,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _destinationsTextController,
                  cursorColor: Color(0xFFB71C1C),
                  decoration: textFormDecoration,
                  validator: (value) {
                    if(value?.isEmpty??false)return "El campo no puede estar vacío";
                    if(int.tryParse(value!)==null)return "El valor no tiene el formato correcto";
                    if(int.tryParse(value)!<2)return "El valor tiene que ser mayor a 2";
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                    context.pop();
                  }, child: Text("Cancelar")
                ),
                SizedBox(width: 10,),
                  FilledButton(
                    style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
                    onPressed: () {
                      if(_formKey.currentState?.validate()??false){
                        context.pop();
                        context.push("/fill_table/${_nameTextController.text}/${_sourcesTextController.text}/${_destinationsTextController.text}");
                      }
                  }, child: Text("Continuar")
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class _CustomTextFormField extends StatelessWidget {
//   const _CustomTextFormField(this.textFormField);
//   final TextFormField textFormField;

//   @override
//   Widget build(BuildContext context) {
//     const borderRadius = Radius.circular(15);
//     return Container(
//       // padding: const EdgeInsets.only(bottom: 0, top: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0,5)
//           ),
//         ]
//       ),
//       child: textFormField,
//     );
//   }
// }