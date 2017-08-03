package streaming.core.compositor.local.output

import java.util

import org.apache.log4j.Logger
import serviceframework.dispatcher.{Compositor, Processor, Strategy}
import streaming.core.compositor.local.CompositorHelper

import scala.collection.mutable.ArrayBuffer

/**
  * @author danran
  * @since 03/08/2017
  */
class PrintCompositor[T] extends Compositor[T] with CompositorHelper {

  private var _configParams: util.List[util.Map[Any, Any]] = _
  val logger = Logger.getLogger(classOf[PrintCompositor[T]].getName)

  override def initialize(typeFilters: util.List[String], configParams: util.List[util.Map[Any, Any]]): Unit = {
    this._configParams = configParams
  }

  val result: util.ArrayList[Any] = new util.ArrayList[Any]()

  def num = {
    config[Int]("num", _configParams)
  }

  override def result(alg: util.List[Processor[T]], ref: util.List[Strategy[T]], middleResult: util.List[T], params: util.Map[Any, Any]): util.List[T] = {
    try {
      val oldRst = middleResult.get(0).asInstanceOf[ArrayBuffer[T]]

      oldRst.slice(0, num.getOrElse(100)).foreach(row => {
        println(row); result.add(row)
      })
    } catch {
      case e: Exception => e.printStackTrace()
    }

    new util.ArrayList[T]()
  }
}
