enum StatusCode {
  operationSucceeded,
  operationFailed,
  fetchSucceeded,
  createSucceeded,
  createFailed,
  insertSucceeded,
  insertFailed,
  updateSucceeded,
  updateFailed,
  deleteSucceeded,
  deleteFailed,
  missingParameter,
  dataNotFound,
  alreadyExists,
  authenticationFailed,
  authorizationFailed,
  invalidPhone,
  invalidData,
  serverError,
}

extension FetchCode on StatusCode {
  int get code {
    switch (this) {
      case StatusCode.operationSucceeded:
        return 200;
      case StatusCode.operationFailed:
        return 510;
      case StatusCode.fetchSucceeded:
        return 210;
      case StatusCode.createSucceeded:
        return 220;
      case StatusCode.createFailed:
        return 520;
      case StatusCode.insertSucceeded:
        return 230;
      case StatusCode.insertFailed:
        return 530;
      case StatusCode.updateSucceeded:
        return 240;
      case StatusCode.updateFailed:
        return 540;
      case StatusCode.deleteSucceeded:
        return 250;
      case StatusCode.deleteFailed:
        return 550;
      case StatusCode.missingParameter:
        return 400;
      case StatusCode.dataNotFound:
        return 410;
      case StatusCode.alreadyExists:
        return 420;
      case StatusCode.authenticationFailed:
        return 430;
      case StatusCode.authorizationFailed:
        return 440;
      case StatusCode.invalidPhone:
        return 450;
      case StatusCode.invalidData:
        return 460;
      case StatusCode.serverError:
        return 560;
    }
  }
}
