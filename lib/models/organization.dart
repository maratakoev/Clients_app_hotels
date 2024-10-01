class Organization {
  final int id;
  final String? email;
  final String? phone;
  final String? title;
  final String? image;
  final String? fullTitle;
  final String? physicalAddress;
  final String? legalAddress;
  final String? description;
  final bool isActive;
  final String? firstName;
  final String? lastName;

  Organization({
    required this.id,
    this.email,
    this.phone,
    this.title,
    this.image,
    this.fullTitle,
    this.physicalAddress,
    this.legalAddress,
    this.description,
    required this.isActive,
    this.firstName,
    this.lastName,
  });

  // Фабричный метод для создания объекта Organization из JSON
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      title: json['title'],
      image: json['image'],
      fullTitle: json['full_title'],
      physicalAddress: json['physical_address'],
      legalAddress: json['legal_address'],
      description: json['description'],
      isActive: json['is_active'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

//модель ответа
class OrganizationResponse {
  final bool success;
  final List<Organization> organizations;

  OrganizationResponse({
    required this.success,
    required this.organizations,
  });

  // Фабричный метод для создания объекта OrganizationResponse из JSON
  factory OrganizationResponse.fromJson(Map<String, dynamic> json) {
    var orgList = json['organizations'] as List;
    List<Organization> organizations =
        orgList.map((orgJson) => Organization.fromJson(orgJson)).toList();

    return OrganizationResponse(
      success: json['success'],
      organizations: organizations,
    );
  }
}
