import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 147, 0, 42),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: const Color.fromARGB(255, 254, 255, 243),
            onPressed: () {},
          ),
          title: const Text(
            'Clase uno',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'perfil',
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 10),
                      Text('Perfil'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'configuracion',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text('Configuración'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'tema',
                  child: Row(
                    children: [
                      Icon(Icons.palette),
                      SizedBox(width: 10),
                      Text('Tema'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: const Color.fromARGB(255, 0, 0, 0),
              child: const Center(
                child: Text(
                  'Container 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            
            Container(
              height: 400,
              width: double.infinity,
              
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                ),

              
              color: const Color.fromARGB(255, 251, 251, 251),
              
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Container(

                      height:100.0,

                      decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16.0),
                      ),
                      
                      child: const Center(
                        child: Text(
                          'Izquierda',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),

                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 244, 228, 0),
                    
                      child: const Center(
                        child: Text(
                          'Centro',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),

                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Derecha',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(0, 82, 147, 1),
          
          selectedItemColor: Colors.white,

          unselectedItemColor: Colors.white70,
          
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Mensajes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}