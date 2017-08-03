package streaming.core.compositor

import serviceframework.dispatcher.StrategyDispatcher
import streaming.core.Dispatcher
import streaming.core.strategy.platform.{LocalRuntime, PlatformManager}

import scala.collection.JavaConversions._
import org.scalatest._
import streaming.common.ParamsUtil
import streaming.core.compositor.local.output.PrintCompositor

/**
  * @author danran
  * @since 03/08/2017
  */
class LocalSpec extends FlatSpec with Matchers {

  val batchParams = Array(
    "-streaming.master", "local[2]",
    "-streaming.name", "unit-test",
    "-streaming.rest", "false",
    "-streaming.platform", "local",
    "-streaming.enableHiveSupport", "false",
    "-streaming.spark.service", "false",
    "-streaming.unittest", "true",
    "-streaming.debug", "true"
  )

  def withBatchContext[R](runtime: LocalRuntime)(block: LocalRuntime => R): R = {
    try {
      block(runtime)
    } finally {
      try {
        StrategyDispatcher.clear
        PlatformManager.getOrCreate
        runtime.destroyRuntime(stopGraceful = false, stopContext = true)
      } catch {
        case e: Exception =>
          e.printStackTrace()
      }
    }
  }

  def setupBatchContext(batchParams: Array[String], configFilePath: String): LocalRuntime = {
    val extraParam = Array("-streaming.job.file.path", configFilePath)
    val params = new ParamsUtil(batchParams ++ extraParam)
    PlatformManager.getOrCreate.run(params, reRun = false)
    val runtime = PlatformManager.getRuntime.asInstanceOf[LocalRuntime]
    runtime
  }

  "batch-local" should "run normally" in {

    withBatchContext(setupBatchContext(batchParams, "classpath:///test/batch-local-test.json")) { runtime: LocalRuntime =>

      val sd = Dispatcher.dispatcher(null)
      val strategies = sd.findStrategies("testLocal").get
      strategies.size should be(1)

      val output = strategies.head.compositor.last.asInstanceOf[PrintCompositor[Any]]
      val result = output.result

      result.size should be(3)

    }
  }

}
