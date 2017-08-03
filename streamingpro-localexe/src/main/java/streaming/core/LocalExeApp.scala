package streaming.core

/**
  * @author danran
  * @since 03/08/2017
  */
object LocalExeApp {
  def main(args: Array[String]): Unit = {
    StreamingApp.main(Array(
      "-streaming.master", "local",
      "-streaming.name", "god",
      "-streaming.rest", "false",
      "-streaming.platform", "local",
      "-streaming.spark.service", "false"
    ))
  }
}
