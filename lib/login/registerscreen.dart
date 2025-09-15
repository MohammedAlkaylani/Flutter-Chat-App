// import 'package:chat_messenger_app/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;

//   late AnimationController _controller;
//   late Animation<double> _formAnimation;

// void register() async {
//   if (_passwordController.text != _confirmPasswordController.text) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Passwords do not match")),
//     );
//     return;
//   }

//   final authService = Provider.of<AuthService>(context, listen: false);

//   try {
//     // Check if account exists
//     bool exists = await authService.checkUserExists(_emailController.text.trim());
//     if (exists) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Account already exists")),
//       );
//       return;
//     }

//     await authService.signUpWithEmailandPassword(
//       _emailController.text.trim(),
//       _passwordController.text.trim(),
//     );

//     // Show success and go to login
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Account created! Please login.")),
//     );
//     Navigator.pop(context); // Go to login screen

//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(e.toString())),
//     );
//   }
// }
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 900),
//       vsync: this,
//     );
//     _formAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOut,
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Create Account"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         foregroundColor: Colors.blueAccent,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             child: FadeTransition(
//               opacity: _formAnimation,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "👋 Welcome!",
//                     style: theme.textTheme.headlineLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.purpleAccent,
//                       fontSize: 32,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Create your account to start chatting",
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(16),
//                     child: TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         prefixIcon: const Icon(Icons.person_outline),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(16),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         prefixIcon: const Icon(Icons.email_outlined),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(16),
//                     child: TextField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                         filled: true,
//                         fillColor: Colors.white,
//                         suffixIcon: IconButton(
//                           icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Material(
//                     elevation: 2,
//                     borderRadius: BorderRadius.circular(16),
//                     child: TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscurePassword,
//                       decoration: InputDecoration(
//                         labelText: "Confirm Password",
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//                         filled: true,
//                         fillColor: Colors.white,
//                         suffixIcon: IconButton(
//                           icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 28),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         backgroundColor: Colors.purpleAccent,
//                         elevation: 4,
//                       ),
//                       onPressed: () {
//                         register();
//                       },
//                       child: const Text("Register", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account?"),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text("Login", style: TextStyle(color: Colors.blueAccent)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:chat_messenger_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> 
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _gradientAnimation;

  void register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Passwords do not match"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      // Check if account exists
      bool exists = await authService.checkUserExists(_emailController.text.trim());
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Account already exists"),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        return;
      }

      await authService.signUpWithEmailandPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Show success and go to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Account created! Please login."),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      Navigator.pop(context); // Go to login screen

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _formAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: Colors.purpleAccent.withOpacity(0.7),
      end: Colors.blueAccent,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _gradientAnimation.value!,
                  Colors.white,
                  Colors.white,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with enhanced animation
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: FadeTransition(
                      opacity: _logoAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.4),
                              blurRadius: 24,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: const Icon(
                          Icons.person_add_rounded,
                          size: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Form with slide and fade animation
                  FadeTransition(
                    opacity: _formAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Text(
                            "👋 Welcome!",
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.purpleAccent,
                              fontSize: 32,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.purple.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            "Create your account to start chatting",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Name field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.person_outline, color: Colors.purpleAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Email field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.purpleAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Password field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.purpleAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Confirm Password field
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _confirmPasswordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(color: Colors.grey[700]),
                                prefixIcon: const Icon(Icons.lock_reset_rounded, color: Colors.purpleAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          
                          const SizedBox(height: 28),
                          
                          // Register button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.purpleAccent,
                                elevation: 6,
                                shadowColor: Colors.purpleAccent.withOpacity(0.4),
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text("Register"),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Login link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blueAccent,
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}