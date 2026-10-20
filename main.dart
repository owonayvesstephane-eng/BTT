import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BatixApp());
}

// ============================================================================
// 1. DESIGN TOKENS OFFICIELS (design_tokens_batix.json) & COMPOSANTS COMPACTS
// ============================================================================
class C {
  static const Color bgDark = Color(0xFF06141D);
  static const Color bgNavy = Color(0xFF0A2232);
  static const Color bgCard = Color(0xFF0D2334);
  static const Color bgInput = Color(0xFF091B29);
  static const Color bgLight = Color(0xFFF4F7FA);

  static const Color greenLight = Color(0xFF4ADE80);
  static const Color green = Color(0xFF10B981);
  static const Color greenDark = Color(0xFF059669);
  static const Color greenRole = Color(0xFF16A34A);

  static const Color orangeGold = Color(0xFFFBBF24);
  static const Color orange = Color(0xFFF59E0B);
  static const Color orangeRole = Color(0xFFEA580C);

  static const Color blueRole = Color(0xFF0284C7);
  static const Color purpleRole = Color(0xFF7C3AED);
  static const Color whatsapp = Color(0xFF1D4ED8);
  static const Color red = Color(0xFFEF4444);
  static const Color border = Color(0x4534D399);

  static const LinearGradient gradOrange = LinearGradient(colors: [orangeGold, orange, orangeRole]);
  static const LinearGradient gradGreen = LinearGradient(colors: [greenLight, greenRole, greenDark]);
  static const RadialGradient gradBg = RadialGradient(
    center: Alignment(0, -0.5),
    radius: 1.3,
    colors: [Color(0x3810B981), bgNavy, bgDark],
  );
}

Widget batixCard({required Widget child, Color? color, Color? borderColor, EdgeInsets? padding, EdgeInsets? margin}) {
  return Container(
    margin: margin ?? const EdgeInsets.only(bottom: 12),
    padding: padding ?? const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color ?? C.bgCard,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: borderColor ?? C.border),
    ),
    child: child,
  );
}

Widget batixBadge(String text, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
    child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
  );
}

class BatixBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isOrange;
  final VoidCallback onTap;

  const BatixBtn({super.key, required this.label, this.icon, this.isOrange = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: isOrange ? C.gradOrange : C.gradGreen,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: (isOrange ? C.orange : C.green).withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 8)],
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 15.5, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

/// Logo BATIX : si showWordmark = false, affiche UNIQUEMENT l'icône du logo sans écrire BATIX en bas
class BatixLogo extends StatelessWidget {
  final double size;
  final bool showWordmark;
  final String? subtitle;
  final bool showSlogan;
  final bool darkText;

  const BatixLogo({super.key, this.size = 68, this.showWordmark = false, this.subtitle, this.showSlogan = false, this.darkText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [C.greenLight, C.greenDark, C.bgNavy]),
            border: Border.all(color: C.orange, width: 2.2),
            boxShadow: [BoxShadow(color: C.green.withOpacity(0.35), blurRadius: 12)],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/batix/apk_icon_only_logo.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: size * 0.14, child: Icon(Icons.location_city_rounded, size: size * 0.42, color: Colors.white)),
                  Positioned(bottom: size * 0.14, child: Icon(Icons.local_shipping_rounded, size: size * 0.42, color: C.orangeGold)),
                ],
              ),
            ),
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: size * 0.36, fontWeight: FontWeight.w900, letterSpacing: 1.2),
              children: [
                TextSpan(text: 'BATI', style: TextStyle(color: darkText ? const Color(0xFF082032) : Colors.white)),
                const TextSpan(text: 'X', style: TextStyle(color: C.orange)),
              ],
            ),
          ),
        ],
        if (subtitle != null) Text(subtitle!, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, letterSpacing: 1.6, color: darkText ? Colors.black54 : Colors.white70)),
        if (showSlogan)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              "L'approvisionnement intelligent\nde vos chantiers.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: darkText ? const Color(0xFF082032) : Colors.white),
            ),
          ),
      ],
    );
  }
}

class GpsMapCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const GpsMapCard({super.key, required this.title, this.subtitle = 'Itinéraire GPS en direct'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(colors: [Color(0xFF0F2D3F), Color(0xFF081B26)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: C.border),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                itemBuilder: (_, __) => Container(decoration: BoxDecoration(border: Border.all(color: C.greenLight, width: 0.3))),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.location_on_rounded, color: C.greenLight, size: 32),
                Container(width: 90, height: 4, color: C.greenLight),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: C.orange, shape: BoxShape.circle),
                  child: const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 22),
                ),
                Container(width: 60, height: 4, color: C.orangeGold),
                const Icon(Icons.flag_circle_rounded, color: C.red, size: 34),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5))),
                  Text(subtitle, style: const TextStyle(color: C.greenLight, fontSize: 11.5, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Stepper4Bar extends StatelessWidget {
  final int step;
  final List<String> labels;
  const Stepper4Bar({super.key, required this.step, required this.labels});

  @override
  Widget build(BuildContext context) {
    return batixCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(labels.length, (i) {
          final done = i <= step;
          return Column(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: done ? C.greenRole : Colors.white12,
                child: Icon(done ? Icons.check_rounded : Icons.lock_outline_rounded, size: 15, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(labels[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, color: done ? C.greenLight : Colors.white54)),
            ],
          );
        }),
      ),
    );
  }
}

// ============================================================================
// 2. DONNÉES PARTAGÉES (Produits, Commandes, Livreurs)
// ============================================================================
class Product {
  String id, name, sub, cat, unit, badge;
  int priceDark, priceLight, stock, threshold;
  IconData icon;
  Color color;
  Product(this.id, this.name, this.sub, this.cat, this.unit, this.priceDark, this.priceLight, this.stock, this.icon, this.color, {this.badge = 'En stock', this.threshold = 50});
}

class Order {
  String id, delivId, client, product, unit, supplier, driver, phone, plate, dest, time, pin, status;
  int qty, total;
  String? p1, p2, p3;
  bool signed;
  Order({
    required this.id, required this.delivId, required this.client, required this.product, required this.qty,
    required this.unit, required this.total, required this.supplier, required this.driver, required this.phone,
    required this.plate, required this.dest, required this.time, required this.pin, required this.status,
    this.p1, this.p2, this.p3, this.signed = false,
  });
}

class Store {
  static final List<Product> products = [
    Product('P1', 'Ciment CPJ 42.5', 'Haute qualité • Sac 50kg', 'Ciment', 'sac', 4700, 8500, 500, Icons.inventory_2_rounded, const Color(0xFFD97706)),
    Product('P2', 'Fer à béton 8mm', 'Acier haute résistance', 'Fer à béton', 'barre', 3500, 4800, 250, Icons.linear_scale_rounded, const Color(0xFF64748B)),
    Product('P3', 'Fer à béton 12mm', 'Barre 12m FeE500', 'Fer à béton', 'barre', 5800, 6800, 180, Icons.reorder_rounded, const Color(0xFF475569)),
    Product('P4', 'Gravier 15/25', 'Granulats concassés', 'Gravier', 'm³', 4200, 4200, 140, Icons.landscape_rounded, const Color(0xFF94A3B8)),
    Product('P5', 'Bois de coffrage', 'Épaisseur 25mm', 'Bois', 'm²', 12000, 12000, 90, Icons.forest_rounded, const Color(0xFFB45309)),
    Product('P6', 'Briques creuses', 'Briques haute densité', 'Brique', 'unité', 250, 300, 1200, Icons.grid_view_rounded, const Color(0xFFEA580C)),
    Product('P7', 'Sable de construction', 'Sable lavé carrière', 'Sable', 'm³', 12000, 12000, 50, Icons.terrain_rounded, const Color(0xFFD97706), badge: 'Stock faible'),
  ];

  static final List<Order> orders = [
    Order(
      id: 'CMD-2025-0089', delivId: 'LIV-2025-0048', client: 'Bâtiment Horizon', product: 'Ciment CPJ 42.5',
      qty: 100, unit: 'sacs', total: 470000, supplier: 'Fournisseur A (Ciment Horizon)', driver: 'Moussa',
      phone: '(+237) 6 57 81 70 43', plate: 'BA-5847-AC', dest: 'Odza (Derrière Tradex) • Quartier Bastos, Yaoundé',
      time: '17/10/2026 - 11:35', pin: '8419', status: 'En préparation',
    ),
    Order(
      id: 'CMD-2025-00124', delivId: 'LIV-2025-0062', client: 'Chantier Riviera', product: 'Ciment (50kg)',
      qty: 200, unit: 'sacs', total: 245000, supplier: 'BATIX Logistics', driver: 'Yannick M.',
      phone: '+237 6 72 45 12 98', plate: 'LT-8821-AB', dest: 'Plateau - Abidjan / Chantier Riviera',
      time: "Aujourd'hui, 14:30", pin: '8419', status: 'En livraison',
    ),
    Order(
      id: 'CMD-2025-0088', delivId: 'LIV-2025-0063', client: 'Entrepôt Akwa', product: 'Fer à béton 8mm',
      qty: 20, unit: 'barres', total: 280000, supplier: 'Ciment Horizon', driver: 'Mbarga T.',
      phone: '+237 6 98 21 45 67', plate: 'CE-4012-BC', dest: 'Entrepôt Akwa',
      time: '11:20 - 17/10/2026', pin: '5521', status: 'En livraison',
    ),
  ];
}

// ============================================================================
// 3. APPLICATION PRINCIPALE & PARTIE 1 : ONBOARDING, AUTH & 4 PROFILS
// ============================================================================
class BatixApp extends StatelessWidget {
  const BatixApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BATIX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: C.bgDark, primaryColor: C.green, useMaterial3: true),
      home: const SplashScreenBatix(),
    );
  }
}

class SplashScreenBatix extends StatefulWidget {
  const SplashScreenBatix({super.key});
  @override
  State<SplashScreenBatix> createState() => _SplashScreenBatixState();
}

class _SplashScreenBatixState extends State<SplashScreenBatix> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen())),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD9ECFA), Color(0xFFFCE2C4), C.bgNavy, C.bgDark],
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const BatixLogo(size: 105, showWordmark: false, showSlogan: true, darkText: true),
                  const Spacer(),
                  const Icon(Icons.local_shipping_rounded, size: 110, color: C.orangeGold),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 65, height: 7, decoration: BoxDecoration(color: C.green, borderRadius: BorderRadius.circular(8))),
                      const SizedBox(width: 6),
                      Container(width: 65, height: 7, decoration: BoxDecoration(color: C.orangeGold, borderRadius: BorderRadius.circular(8))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Votre partenaire logistique de confiance', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const BatixLogo(size: 96, showWordmark: false, showSlogan: true),
                const Spacer(),
                batixCard(
                  padding: const EdgeInsets.all(24),
                  child: const Column(
                    children: [
                      Icon(Icons.local_shipping_rounded, size: 80, color: C.orangeGold),
                      SizedBox(height: 8),
                      Text('Ensemble pour des chantiers plus performants !', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [Icon(Icons.layers_rounded, color: C.greenLight), SizedBox(height: 4), Text('Matériaux BTP', style: TextStyle(fontSize: 12))]),
                    Column(children: [Icon(Icons.local_shipping_rounded, color: C.greenLight), SizedBox(height: 4), Text('Livraison rapide', style: TextStyle(fontSize: 12))]),
                    Column(children: [Icon(Icons.verified_rounded, color: C.greenLight), SizedBox(height: 4), Text('Partenaires fiables', style: TextStyle(fontSize: 12))]),
                  ],
                ),
                const SizedBox(height: 24),
                BatixBtn(
                  label: 'Commencer  →',
                  isOrange: true,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WelcomeAuthScreen())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft, child: BackButton(color: Colors.white, onPressed: () => Navigator.pop(context))),
                const BatixLogo(size: 86, showWordmark: false),
                const SizedBox(height: 18),
                const Text('Bienvenue sur BATIX', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text('Connectez-vous ou créez votre compte\npour accéder à tous les services.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 28),
                BatixBtn(label: "S'inscrire", icon: Icons.person_add_alt_1_rounded, isOrange: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen()))),
                const SizedBox(height: 14),
                BatixBtn(label: 'Se connecter', icon: Icons.login_rounded, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87, minimumSize: const Size(double.infinity, 52)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
                  icon: const Icon(Icons.play_circle_outline_rounded),
                  label: const Text('Mode démo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const Spacer(),
                const Text('Ensemble pour des chantiers plus performants !', style: TextStyle(fontStyle: FontStyle.italic, color: C.orangeGold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              const Align(alignment: Alignment.centerLeft, child: BackButton(color: Colors.white)),
              const BatixLogo(size: 80, showWordmark: false, showSlogan: true),
              const SizedBox(height: 20),
              batixCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Se connecter', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Text('Accédez à votre espace en toute sécurité', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 16),
                    TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.email_outlined), hintText: 'client@batix.com', filled: true, fillColor: C.bgInput, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
                    const SizedBox(height: 12),
                    TextField(obscureText: true, decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline_rounded), hintText: 'Mot de passe', filled: true, fillColor: C.bgInput, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)))),
                    const SizedBox(height: 16),
                    BatixBtn(label: 'Se connecter', icon: Icons.arrow_forward_rounded, isOrange: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen()))),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48), side: const BorderSide(color: C.greenLight)),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 28, color: C.orangeGold),
                      label: const Text('Se connecter avec Google', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileChoiceScreen extends StatelessWidget {
  const ProfileChoiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final roles = [
      {'title': 'Client', 'desc': 'Trouvez et commandez vos matériaux.', 'icon': Icons.person_rounded, 'color': C.greenRole, 'page': const ClientWorkspace()},
      {'title': 'Fournisseur', 'desc': 'Vendez vos matériaux aux professionnels.', 'icon': Icons.factory_rounded, 'color': C.orangeRole, 'page': const SupplierWorkspace()},
      {'title': 'Transporteur / Livreur', 'desc': 'Livrez en toute sécurité vos commandes.', 'icon': Icons.local_shipping_rounded, 'color': C.blueRole, 'page': const DriverWorkspace()},
      {'title': 'Agent BATIX', 'desc': 'Gérez les inscriptions et le suivi.', 'icon': Icons.verified_user_rounded, 'color': C.purpleRole, 'page': const AgentWorkspace()},
    ];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const BatixLogo(size: 62, showWordmark: false),
                const SizedBox(height: 12),
                const Text('Choisissez votre profil', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                const Text('Sélectionnez le profil qui correspond à votre activité.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.84,
                    children: roles.map((r) {
                      return GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => r['page'] as Widget)),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(radius: 26, backgroundColor: r['color'] as Color, child: Icon(r['icon'] as IconData, color: Colors.white, size: 28)),
                              const SizedBox(height: 12),
                              Text(r['title'] as String, style: const TextStyle(color: Color(0xFF082032), fontSize: 15.5, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Expanded(child: Text(r['desc'] as String, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12))),
                              const Align(alignment: Alignment.bottomRight, child: Icon(Icons.chevron_right_rounded, color: Color(0xFF082032))),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// PARTIE 2 & PARTIE 3 : ESPACE CLIENT (Mode Clair + Mode Sombre "Marché Intelligent")
// ============================================================================
class ClientWorkspace extends StatefulWidget {
  const ClientWorkspace({super.key});
  @override
  State<ClientWorkspace> createState() => _ClientWorkspaceState();
}

class _ClientWorkspaceState extends State<ClientWorkspace> {
  bool _darkMarket = false;
  int _tab = 0;
  String _cat = 'Tous';
  final Map<String, int> _qty = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkMarket ? C.bgDark : C.bgLight,
      appBar: AppBar(
        backgroundColor: _darkMarket ? C.bgDark : Colors.white,
        iconTheme: IconThemeData(color: _darkMarket ? Colors.white : Colors.black87),
        title: BatixLogo(size: 34, showWordmark: false, subtitle: _darkMarket ? 'LE MARCHÉ INTELLIGENT' : 'ESPACE CLIENT', darkText: !_darkMarket),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Mode Clair / Sombre',
            icon: Icon(_darkMarket ? Icons.light_mode_rounded : Icons.dark_mode_rounded, color: C.orange),
            onPressed: () => setState(() => _darkMarket = !_darkMarket),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded, color: C.green),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
          ),
        ],
      ),
      body: _tab == 0 ? _buildHome() : _tab == 1 ? _buildCatalog() : _tab == 2 ? _buildTracking() : _buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _darkMarket ? C.bgNavy : Colors.white,
        selectedItemColor: C.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: 'Livraison'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: C.gradGreen),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Des matériaux au bon endroit,\nau bon moment !', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () => setState(() => _tab = 1), child: const Text('Commander →')),
                  ],
                ),
              ),
              const Icon(Icons.local_shipping_rounded, size: 64, color: Colors.white),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text('Produits en vedette', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _darkMarket ? Colors.white : Colors.black87)),
        const SizedBox(height: 10),
        ...Store.products.take(4).map((p) => _productRow(p)),
      ],
    );
  }

  Widget _buildCatalog() {
    final cats = ['Tous', 'Ciment', 'Fer à béton', 'Gravier', 'Bois', 'Brique'];
    final list = Store.products.where((p) => _cat == 'Tous' || p.cat == _cat).toList();
    return Column(
      children: [
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            children: cats.map((c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(label: Text(c), selected: _cat == c, selectedColor: C.green, onSelected: (_) => setState(() => _cat = c)),
            )).toList(),
          ),
        ),
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: list.map(_productRow).toList())),
      ],
    );
  }

  Widget _productRow(Product p) {
    final q = _qty[p.id] ?? 1;
    final price = _darkMarket ? p.priceDark : p.priceLight;
    return batixCard(
      color: _darkMarket ? C.bgCard : Colors.white,
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundColor: p.color.withOpacity(0.2), child: Icon(p.icon, color: p.color, size: 30)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5, color: _darkMarket ? Colors.white : Colors.black87)),
                Text('$price FCFA / ${p.unit}', style: const TextStyle(color: C.orange, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.remove_circle_outline, color: C.green), onPressed: () => setState(() => _qty[p.id] = max(1, q - 1))),
                    Text('$q', style: TextStyle(fontWeight: FontWeight.bold, color: _darkMarket ? Colors.white : Colors.black87)),
                    IconButton(icon: const Icon(Icons.add_circle_outline, color: C.green), onPressed: () => setState(() => _qty[p.id] = q + 1)),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: C.greenRole, foregroundColor: Colors.white),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ComparatorScreen(product: p, qty: q))),
                      child: const Text('Ajouter'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTracking() {
    final o = Store.orders.first;
    return Container(
      decoration: const BoxDecoration(gradient: C.gradBg),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Suivi de commande • ${o.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GpsMapCard(title: o.dest, subtitle: 'Arrivée : 11:35 (30 min)'),
          const SizedBox(height: 12),
          const Stepper4Bar(step: 2, labels: ['Confirmée', 'Préparation', 'En transit', 'Livrée']),
          batixCard(
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: C.blueRole, child: Icon(Icons.person, color: Colors.white)),
              title: Text('Chauffeur ${o.driver} (⭐ 4.9)', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Véhicule ${o.plate} • Code secret : ${o.pin}'),
              trailing: const Icon(Icons.phone_in_talk_rounded, color: C.greenLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        batixCard(
          color: Colors.white,
          child: ListTile(
            leading: const CircleAvatar(radius: 28, backgroundColor: C.greenRole, child: Icon(Icons.person, color: Colors.white)),
            title: const Text('Client Batix', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
            subtitle: const Text('client@batix.com', style: TextStyle(color: Colors.black54)),
            trailing: batixBadge('Client', C.greenRole),
          ),
        ),
      ],
    );
  }
}

class ComparatorScreen extends StatelessWidget {
  final Product product;
  final int qty;
  const ComparatorScreen({super.key, required this.product, required this.qty});

  @override
  Widget build(BuildContext context) {
    final suppliers = [
      {'name': 'Fournisseur A', 'rate': '4.8 (120 avis)', 'price': product.priceDark, 'dist': '1,2 km', 'time': '30 min'},
      {'name': 'Fournisseur B', 'rate': '4.5 (66 avis)', 'price': product.priceDark + 150, 'dist': '2,5 km', 'time': '1 h'},
      {'name': 'Fournisseur C', 'rate': '4.6 (72 avis)', 'price': product.priceDark + 290, 'dist': '4,8 km', 'time': '3 h'},
    ];
    return Scaffold(
      appBar: AppBar(backgroundColor: C.bgDark, title: Text(product.name)),
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Fournisseurs disponibles • 📍 Dans votre zone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...suppliers.map((s) => batixCard(
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: C.greenRole, child: Icon(Icons.storefront_rounded, color: Colors.white)),
                title: Text('${s['name']} • ⭐ ${s['rate']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${s['price']} FCFA/${product.unit} • 📍 ${s['dist']} • 🕒 ${s['time']}'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: C.greenRole, foregroundColor: Colors.white),
                  onPressed: () {
                    final pin = (1000 + Random().nextInt(9000)).toString();
                    final order = Order(
                      id: 'CMD-2025-0095', delivId: 'LIV-2025-0055', client: 'Bâtiment Horizon', product: product.name,
                      qty: qty, unit: product.unit, total: (s['price'] as int) * qty, supplier: s['name'] as String,
                      driver: 'Moussa', phone: '+237 6 57 81 70 43', plate: 'BA-5847-AC', dest: 'Quartier Bastos, Yaoundé',
                      time: '17/10/2026 - 11:35', pin: pin, status: 'En cours',
                    );
                    Store.orders.insert(0, order);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: C.bgCard,
                        title: const Text('Commande confirmée ! ✅'),
                        content: Text('N° ${order.id}\nTotal : ${order.total} FCFA\nCode secret à 4 chiffres : ${order.pin}'),
                        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('OK'))],
                      ),
                    );
                  },
                  child: const Text('Choisir'),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// PARTIE 4 : ESPACE FOURNISSEUR (Ciment Horizon - Produits, Excel, Commandes, Flotte)
// ============================================================================
class SupplierWorkspace extends StatefulWidget {
  const SupplierWorkspace({super.key});
  @override
  State<SupplierWorkspace> createState() => _SupplierWorkspaceState();
}

class _SupplierWorkspaceState extends State<SupplierWorkspace> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.bgDark,
        centerTitle: true,
        title: const BatixLogo(size: 34, showWordmark: false, subtitle: 'ESPACE FOURNISSEUR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded, color: C.greenLight),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: _tab == 0 ? _buildOverview() : _tab == 1 ? _buildProducts() : _tab == 2 ? _buildOrders() : _buildDrivers(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: C.bgNavy,
        selectedItemColor: C.greenLight,
        unselectedItemColor: Colors.white54,
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_rounded), label: 'Produits'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Commandes'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_rounded), label: 'Livreurs'),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        batixCard(
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: C.blueRole, child: Icon(Icons.factory_rounded, color: Colors.white)),
            title: const Text('Ciment Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            subtitle: const Text('Fournisseur A'),
            trailing: batixBadge('En ligne', C.greenRole),
          ),
        ),
        _kpi("Ventes aujourd'hui", '248 500 FCFA', '12 commandes', C.greenRole, Icons.trending_up_rounded),
        _kpi('Commandes en cours', '7', 'En livraison / préparation', C.blueRole, Icons.local_shipping_rounded),
        _kpi('En attente de confirmation', '3', 'À valider', C.orangeRole, Icons.access_time_rounded),
        _kpi('Livraisons terminées', '9', "Aujourd'hui", C.greenRole, Icons.check_circle_rounded),
      ],
    );
  }

  Widget _kpi(String title, String val, String sub, Color col, IconData icon) {
    return batixCard(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: col, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        subtitle: Text('$val  •  $sub', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildProducts() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BatixBtn(
          label: 'Importer une liste Excel (.xlsx, .xls)',
          icon: Icons.upload_file_rounded,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Import Excel synchronisé avec succès !'))),
        ),
        const SizedBox(height: 12),
        ...Store.products.map((p) => batixCard(
          child: ListTile(
            leading: Icon(p.icon, color: p.color, size: 34),
            title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Stock : ${p.stock} ${p.unit}s • ${p.priceDark} FCFA'),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_rounded, color: C.greenLight),
              onPressed: () => setState(() => p.stock += 20),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: Store.orders.map((o) => batixCard(
        child: ListTile(
          title: Text('#${o.id} • ${o.product} (${o.qty} ${o.unit})', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${o.total} FCFA • ${o.time}'),
          trailing: batixBadge(o.status, C.blueRole),
        ),
      )).toList(),
    );
  }

  Widget _buildDrivers() {
    final drivers = [
      {'name': 'Yannick M.', 'phone': '+237 6 72 45 12 98', 'status': 'En livraison'},
      {'name': 'Mbarga T.', 'phone': '+237 6 98 21 45 67', 'status': 'En livraison'},
      {'name': 'Salifou D.', 'phone': '+237 6 70 12 34 56', 'status': 'En route'},
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...drivers.map((d) => batixCard(
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: C.blueRole, child: Icon(Icons.person, color: Colors.white)),
            title: Text(d['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${d['phone']} • 🚚 ${d['status']}'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: C.greenRole, foregroundColor: Colors.white),
              onPressed: () => _showDriverContactSheet(context, d['name']!, d['phone']!),
              child: const Text('Contacter'),
            ),
          ),
        )),
        const GpsMapCard(title: 'Yannick M. • En livraison (12 min • 4,2 km)'),
      ],
    );
  }

  void _showDriverContactSheet(BuildContext context, String name, String phone) {
    showModalBottomSheet(
      context: context,
      backgroundColor: C.bgDark,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Contacter $name ($phone)', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: BatixBtn(label: 'Appeler', icon: Icons.phone, onTap: () => Navigator.pop(context))),
                const SizedBox(width: 10),
                Expanded(child: BatixBtn(label: 'WhatsApp', icon: Icons.chat, isOrange: true, onTap: () => Navigator.pop(context))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// PARTIE 5 : ESPACE CHAUFFEUR / LIVRAISON GPS (Bienvenue Moussa + 5 Étapes)
// ============================================================================
class DriverWorkspace extends StatelessWidget {
  const DriverWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.bgDark,
        centerTitle: true,
        title: const BatixLogo(size: 34, showWordmark: false, subtitle: 'ESPACE CHAUFFEUR GPS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded, color: C.greenLight),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Bonjour, Moussa ! 👋', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
            const Text('🟢 En ligne • Prêt pour vos livraisons d’aujourd’hui ? 🚚', style: TextStyle(color: C.greenLight)),
            const SizedBox(height: 16),
            const Text('LIVRAISONS DISPONIBLES (3 opportunités proches)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...Store.orders.map((o) => batixCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('N° ${o.delivId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      batixBadge('8,4 km', C.orangeRole),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${o.product} (${o.qty} ${o.unit}) • Client : ${o.client}'),
                  Text('📍 ${o.dest}', style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                  const SizedBox(height: 10),
                  BatixBtn(
                    label: 'Accepter et démarrer la livraison →',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DriverDeliveryWizard(order: o))),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

/// Parcours Chauffeur en 5 étapes (Détails -> GPS 3D -> Preuve Photo Caméra Directe -> Signature + Code 4 cases -> Finalisée)
class DriverDeliveryWizard extends StatefulWidget {
  final Order order;
  const DriverDeliveryWizard({super.key, required this.order});
  @override
  State<DriverDeliveryWizard> createState() => _DriverDeliveryWizardState();
}

class _DriverDeliveryWizardState extends State<DriverDeliveryWizard> {
  int _step = 0; // 0: Détails, 1: GPS 3D, 2: Preuve Photo, 3: Signature + Code 4 cases, 4: Livraison Finalisée
  final ImagePicker _picker = ImagePicker();
  final List<TextEditingController> _pinCtrls = List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _pinCtrls[i].text = widget.order.pin[i];
    }
  }

  Future<void> _takeDirectPhoto(int numPhoto) async {
    try {
      final XFile? img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
      setState(() {
        final path = img?.path ?? 'Caméra_Directe_Photo_$numPhoto.jpg';
        if (numPhoto == 1) widget.order.p1 = path;
        if (numPhoto == 2) widget.order.p2 = path;
        if (numPhoto == 3) widget.order.p3 = path;
      });
    } catch (_) {
      setState(() {
        if (numPhoto == 1) widget.order.p1 = 'Caméra_Directe_Chargement.jpg';
        if (numPhoto == 2) widget.order.p2 = 'Caméra_Directe_Arrivée.jpg';
        if (numPhoto == 3) widget.order.p3 = 'Caméra_Directe_Déchargement.jpg';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    return Scaffold(
      appBar: AppBar(backgroundColor: C.bgDark, title: Text('Livraison ${o.delivId}')),
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Stepper4Bar(step: min(_step, 3), labels: const ['En route', 'Arrivée', 'Livraison', 'Signature']),
            const SizedBox(height: 12),
            if (_step == 0) ...[
              batixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('N° ${o.delivId} • Client : ${o.client}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('📍 ${o.dest}'),
                    Text('🚚 ${o.product} (${o.qty} ${o.unit})'),
                  ],
                ),
              ),
              GpsMapCard(title: o.dest),
              const SizedBox(height: 16),
              BatixBtn(label: 'Démarrer la livraison →', onTap: () => setState(() => _step = 1)),
            ] else if (_step == 1) ...[
              batixCard(
                child: const ListTile(
                  leading: Icon(Icons.turn_right_rounded, color: C.greenLight, size: 36),
                  title: Text('Tourner à droite à 500m', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text('15 min restantes • Navigation GPS 3D active'),
                ),
              ),
              GpsMapCard(title: 'Vue GPS 3D • Camion ${o.plate}', subtitle: 'En route'),
              const SizedBox(height: 16),
              BatixBtn(label: 'Arriver au chantier →', onTap: () => setState(() => _step = 2)),
            ] else if (_step == 2) ...[
              const Text('Preuve de livraison (Caméra directe obligatoire)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _photoBtn(1, '1. Photo au chargement', o.p1),
              _photoBtn(2, '2. Photo arrivée chantier', o.p2),
              _photoBtn(3, '3. Photo matériaux déchargés', o.p3),
              const SizedBox(height: 16),
              BatixBtn(
                label: 'Confirmer le déchargement →',
                onTap: () {
                  if (o.p1 == null || o.p2 == null || o.p3 == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez capturer les 3 photos obligatoires.')));
                    return;
                  }
                  setState(() => _step = 3);
                },
              ),
            ] else if (_step == 3) ...[
              batixCard(
                color: Colors.white,
                child: Column(
                  children: [
                    const Text('Faites signer le client', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => setState(() => o.signed = true),
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            o.signed ? 'Signature validée : B. Manu ✍️' : 'Touchez ici pour signer ✍️',
                            style: const TextStyle(color: Colors.black87, fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              batixCard(
                child: Column(
                  children: [
                    const Text('Code de validation à 4 chiffres', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('Le client doit confirmer avec le code secret', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (i) => SizedBox(
                        width: 56,
                        child: TextField(
                          controller: _pinCtrls[i],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(counterText: '', filled: true, fillColor: C.bgInput, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              BatixBtn(
                label: 'Valider et terminer →',
                onTap: () {
                  o.signed = true;
                  o.status = 'Livrée';
                  setState(() => _step = 4);
                },
              ),
            ] else ...[
              const SizedBox(height: 20),
              const CircleAvatar(radius: 52, backgroundColor: C.greenRole, child: Icon(Icons.check_rounded, size: 64, color: Colors.white)),
              const SizedBox(height: 16),
              const Text('Livraison Finalisée !', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              const Text('Merci, la commande a été livrée et validée avec succès.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              batixCard(
                child: ListTile(
                  leading: const Icon(Icons.inventory_2_rounded, color: C.orangeGold, size: 36),
                  title: Text('N° ${o.delivId} • Client : ${o.client}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Heure de validation : 10:45'),
                  trailing: const Icon(Icons.check_circle_rounded, color: C.greenLight, size: 30),
                ),
              ),
              const SizedBox(height: 20),
              BatixBtn(label: 'Fermer', onTap: () => Navigator.pop(context)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _photoBtn(int idx, String label, String? val) {
    return batixCard(
      child: ListTile(
        leading: Icon(val != null ? Icons.check_circle_rounded : Icons.camera_alt_rounded, color: val != null ? C.greenLight : C.orangeGold),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(val ?? 'Aucune photo capturée'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: C.greenRole, foregroundColor: Colors.white),
          onPressed: () => _takeDirectPhoto(idx),
          child: const Text('Caméra'),
        ),
      ),
    );
  }
}

// ============================================================================
// CONSOLE AGENT BATIX (Supervision des 3 photos & codes secrets)
// ============================================================================
class AgentWorkspace extends StatelessWidget {
  const AgentWorkspace({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: C.bgDark,
        title: const BatixLogo(size: 34, showWordmark: false, subtitle: 'CONSOLE AGENT BATIX'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz_rounded, color: C.greenLight),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileChoiceScreen())),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: C.gradBg),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Audit des Livraisons & Codes Secrets', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...Store.orders.map((o) => batixCard(
              child: ListTile(
                title: Text('${o.id} (${o.delivId}) • ${o.product}', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Client : ${o.client} • Chauffeur : ${o.driver}\nCode secret : ${o.pin} • Statut : ${o.status}'),
                trailing: batixBadge(o.status, o.status == 'Livrée' ? C.greenRole : C.purpleRole),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
// === FIN DU FICHIER lib/main.dart (100% COMPLET ET PRÊT À COMPILER) ===
