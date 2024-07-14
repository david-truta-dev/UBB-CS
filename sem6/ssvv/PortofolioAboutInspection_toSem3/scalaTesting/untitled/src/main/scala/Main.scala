object Main {
  def main(args: Array[String]): Unit = {
    val a = 3
    val b = "numa bine rau la nime"

    //IdenticalCaseBodies:
    a match {
      case 3 => "hello"
      case 4 => "hello"
      case 5 => "hello"
      case _ => "how low"
    }

    //Unnecessary if:
    if (a == b) true else false

    //Using log(1 + a) instead of log1p(a)
    math.log(1d + a)

  }
}